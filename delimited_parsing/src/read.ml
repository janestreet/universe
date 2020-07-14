open Core
open Async
include Delimited_kernel.Read
open Deferred.Let_syntax
open! Int.Replace_polymorphic_compare

(* the maximum read/write I managed to get off of a socket or disk was 65k *)
let buffer_size = 10 * 65 * 1024

module Streaming = struct
  include Delimited_kernel.Read.Streaming

  let input_reader t r =
    let buffer = Bytes.create buffer_size in
    Deferred.repeat_until_finished t (fun t ->
      match%map Reader.read r buffer ~len:buffer_size with
      | `Eof -> `Finished t
      | `Ok len ->
        let t = Streaming.input t buffer ~len in
        `Repeat t)
  ;;

  let read_file
        ?strip
        ?sep
        ?quote
        ?start_line_number
        ?on_invalid_row
        ?header
        builder
        ~init
        ~f
        ~filename
    =
    let t =
      create
        ?strip
        ?sep
        ?quote
        ?start_line_number
        ?on_invalid_row
        ?header
        builder
        ~init
        ~f
    in
    let%map t = Reader.with_file filename ~f:(input_reader t) in
    let t = finish t in
    t
  ;;
end

let fold_reader'
      ?strip
      ?(skip_lines = 0)
      ?sep
      ?quote
      ?header
      ?on_invalid_row
      builder
      ~init
      ~f
      r
  =
  let%bind () = Shared.drop_lines r skip_lines in
  let buffer = Bytes.create buffer_size in
  let queue = Queue.create () in
  let state =
    Streaming.create
      ?strip
      ?sep
      ?quote
      ~start_line_number:(skip_lines + 1)
      ?header
      ?on_invalid_row
      builder
      ~init:()
      ~f:(fun () elt -> Queue.enqueue queue elt)
  in
  Deferred.repeat_until_finished (state, init) (fun (state, acc) ->
    match%bind Reader.read r buffer ~len:buffer_size with
    | `Eof ->
      let (_ : unit Streaming.t) = Streaming.finish state in
      let%bind acc = if Queue.is_empty queue then return acc else f acc queue in
      Queue.clear queue;
      let%map () = Reader.close r in
      `Finished acc
    | `Ok len ->
      let state = Streaming.input state buffer ~len in
      let%map acc = if Queue.is_empty queue then return acc else f acc queue in
      Queue.clear queue;
      `Repeat (state, acc))
;;

let bind_without_unnecessary_yielding x ~f =
  match Deferred.peek x with
  | Some x -> f x
  | None -> Deferred.bind x ~f
;;

let fold_reader ?strip ?skip_lines ?sep ?quote ?header ?on_invalid_row builder ~init ~f r
  =
  fold_reader'
    ?strip
    ?skip_lines
    ?sep
    ?quote
    ?header
    ?on_invalid_row
    builder
    ~init
    r
    ~f:(fun acc queue ->
      Queue.fold queue ~init:(return acc) ~f:(fun deferred_acc row ->
        bind_without_unnecessary_yielding deferred_acc ~f:(fun acc -> f acc row)))
;;

let fold_reader_without_pushback
      ?strip
      ?skip_lines
      ?sep
      ?quote
      ?header
      ?on_invalid_row
      builder
      ~init
      ~f
      r
  =
  fold_reader'
    ?strip
    ?skip_lines
    ?sep
    ?quote
    ?header
    ?on_invalid_row
    builder
    ~init
    r
    ~f:(fun acc queue -> return (Queue.fold queue ~init:acc ~f))
;;

let pipe_of_reader ?strip ?skip_lines ?sep ?quote ?header ?on_invalid_row builder reader =
  let r, w = Pipe.create () in
  let write_to_pipe : unit Deferred.t =
    let%bind () =
      fold_reader'
        ?strip
        ?skip_lines
        ?sep
        ?quote
        ?header
        ?on_invalid_row
        builder
        ~init:()
        reader
        ~f:(fun () queue ->
          if Pipe.is_closed w
          then (
            let%bind () = Reader.close reader in
            Deferred.never ())
          else Pipe.transfer_in w ~from:queue)
    in
    return (Pipe.close w)
  in
  don't_wait_for write_to_pipe;
  r
;;

let create_reader ?strip ?skip_lines ?sep ?quote ?header ?on_invalid_row builder filename
  =
  Reader.open_file filename
  >>| pipe_of_reader ?strip ?skip_lines ?sep ?quote ?header ?on_invalid_row builder
;;
