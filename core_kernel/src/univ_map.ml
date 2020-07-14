open! Import
open Std_internal
include Univ_map_intf
module Uid = Type_equal.Id.Uid

module Make1
    (Key : Key) (Data : sig
                   type ('s, 'a) t [@@deriving sexp_of]
                 end) =
struct
  (* A wrapper for the [Key] module that adds a dynamic check to [Key.to_type_id].

     It's a bug if the user-provided [Key.to_type_id] gives different type ids on
     different calls.  Because this check should be fairly cheap, we do it dynamically to
     avoid subtler problems later.

     Of course, we're not checking truly pathological things like the provided
     [Key.to_type_id] only changes the value it returns on every third call...
  *)
  module Key = struct
    type 'a t = 'a Key.t [@@deriving sexp_of]

    (* test-friendly sexp conversion *)
    let sexp_of_type_id type_id =
      [%sexp
        { name = (Type_equal.Id.name type_id : string)
        ; uid =
            ((if am_running_inline_test
              then Sexp.Atom "<uid>"
              else Type_equal.Id.Uid.sexp_of_t (Type_equal.Id.uid type_id)) : Sexp.t)
        }]
    ;;

    let to_type_id key =
      let type_id1 = Key.to_type_id key in
      let type_id2 = Key.to_type_id key in
      if Type_equal.Id.same type_id1 type_id2
      then type_id1
      else
        raise_s
          [%message
            "[Key.to_type_id] must not provide different type ids when called on the \
             same input"
              (key : _ Key.t)
              (type_id1 : type_id)
              (type_id2 : type_id)]
    ;;
  end

  type ('s, 'a) data = ('s, 'a) Data.t

  let name_of_key key = Type_equal.Id.name (Key.to_type_id key)
  let uid_of_key key = Type_equal.Id.uid (Key.to_type_id key)

  module Packed = struct
    type 's t = T : 'a Key.t * ('s, 'a) Data.t -> 's t

    let sexp_of_t sexp_of_a (T (key, data)) =
      Data.sexp_of_t sexp_of_a (Type_equal.Id.to_sexp (Key.to_type_id key)) data
    ;;

    let type_id_name (T (key, _)) = name_of_key key
    let type_id_uid (T (key, _)) = uid_of_key key
  end

  type 's t = 's Packed.t Uid.Map.t

  let sexp_of_t sexp_of_a t =
    Map.data t
    |> List.map ~f:(fun u -> Packed.type_id_name u, u)
    |> List.sort ~compare:(fun (a, _) (b, _) -> String.compare a b)
    |> [%sexp_of: (string * a Packed.t) list]
  ;;

  let invariant (t : _ t) =
    Invariant.invariant [%here] t [%sexp_of: _ t] (fun () ->
      Map.iteri t ~f:(fun ~key ~data ->
        assert (Uid.equal key (Packed.type_id_uid data))))
  ;;

  let set t ~key ~data = Map.set t ~key:(uid_of_key key) ~data:(Packed.T (key, data))
  let mem_by_id t id = Map.mem t id
  let mem t key = mem_by_id t (uid_of_key key)
  let remove_by_id t id = Map.remove t id
  let remove t key = remove_by_id t (uid_of_key key)
  let empty = Uid.Map.empty
  let is_empty = Map.is_empty

  let find (type b) t (key : b Key.t) =
    match Map.find t (uid_of_key key) with
    | None -> None
    | Some (Packed.T (key', value)) ->
      (* cannot raise -- see [invariant] *)
      let Type_equal.T =
        Type_equal.Id.same_witness_exn (Key.to_type_id key) (Key.to_type_id key')
      in
      Some (value : (_, b) Data.t)
  ;;

  let find_exn t key =
    match find t key with
    | Some data -> data
    | None -> failwithf "Univ_map.find_exn on unknown key %s" (name_of_key key) ()
  ;;

  let add t ~key ~data = if mem t key then `Duplicate else `Ok (set t ~key ~data)

  let add_exn t ~key ~data =
    match add t ~key ~data with
    | `Ok t -> t
    | `Duplicate -> failwithf "Univ_map.add_exn on existing key %s" (name_of_key key) ()
  ;;

  let change_exn t key ~f:update =
    match find t key with
    | Some data -> set t ~key ~data:(update data)
    | None -> failwithf "Univ_map.change_exn on unknown key %s" (name_of_key key) ()
  ;;

  let change t key ~f:update =
    let orig = find t key in
    let next = update orig in
    match next with
    | Some data -> set t ~key ~data
    | None -> if Option.is_none orig then t else remove t key
  ;;

  let update t key ~f = change t key ~f:(fun data -> Some (f data))
  let to_alist t = Map.data t

  let of_alist_exn t =
    Uid.Map.of_alist_exn (List.map t ~f:(fun p -> Packed.type_id_uid p, p))
  ;;
end

module Make
    (Key : Key) (Data : sig
                   type 'a t [@@deriving sexp_of]
                 end) =
struct
  module M =
    Make1
      (Key)
      (struct
        type (_, 'a) t = 'a Data.t [@@deriving sexp_of]
      end)

  type t = unit M.t [@@deriving sexp_of]

  module Key = Key

  type 'a data = 'a Data.t

  let invariant = M.invariant
  let empty = M.empty
  let is_empty = M.is_empty
  let set = M.set
  let mem = M.mem
  let mem_by_id = M.mem_by_id
  let find = M.find
  let find_exn = M.find_exn
  let add = M.add
  let add_exn = M.add_exn
  let change = M.change
  let change_exn = M.change_exn
  let update = M.update
  let remove = M.remove
  let remove_by_id = M.remove_by_id

  module Packed = struct
    type t = T : 'a Key.t * 'a Data.t -> t
  end

  let to_alist t =
    List.map (M.to_alist t) ~f:(function M.Packed.T (key, data) -> Packed.T (key, data))
  ;;

  let of_alist_exn t =
    M.of_alist_exn
      (List.map t ~f:(function Packed.T (key, data) -> M.Packed.T (key, data)))
  ;;
end

module Merge
    (Key : Key)
    (Input1_data : Data1)
    (Input2_data : Data1)
    (Output_data : Data1) =
struct
  type 's f =
    { f :
        'a. key:'a Key.t
        -> [ `Left of ('s, 'a) Input1_data.t
           | `Right of ('s, 'a) Input2_data.t
           | `Both of ('s, 'a) Input1_data.t * ('s, 'a) Input2_data.t
           ] -> ('s, 'a) Output_data.t option
    }

  module Output = Make1 (Key) (Output_data)

  let merge
        (type s)
        (t1 : s Make1(Key)(Input1_data).t)
        (t2 : s Make1(Key)(Input2_data).t)
        ~f:{ f }
    =
    let f ~key merge_result =
      Option.map (f ~key merge_result) ~f:(fun data -> Output.Packed.T (key, data))
    in
    Map.merge t1 t2 ~f:(fun ~key:_ ->
      function
      | `Left (T (key, data)) -> f ~key (`Left data)
      | `Right (T (key, data)) -> f ~key (`Right data)
      | `Both (T (left_key, left_data), T (right_key, right_data)) ->
        (* Can't raise due to the invariant *)
        let Type_equal.T =
          Type_equal.Id.same_witness_exn
            (Key.to_type_id left_key)
            (Key.to_type_id right_key)
        in
        f ~key:left_key (`Both (left_data, right_data)))
  ;;
end

module Type_id_key = struct
  type 'a t = 'a Type_equal.Id.t [@@deriving sexp_of]

  let to_type_id = Fn.id
end

include (
  Make
    (Type_id_key)
    (struct
      type 'a t = 'a [@@deriving sexp_of]
    end) :
    S with type 'a data = 'a and module Key := Type_id_key)

module Key = Type_equal.Id

module With_default = struct
  module Key = struct
    type 'a t =
      { key : 'a Type_equal.Id.t
      ; default : 'a
      }

    let create ~default ~name sexp_of =
      { default; key = Type_equal.Id.create ~name sexp_of }
    ;;

    let id t = t.key
  end

  let find t { Key.key; default } = Option.value ~default (find t key)
  let set t ~key:{ Key.key; default = _ } ~data = set t ~key ~data
  let change t key ~f:update = set t ~key ~data:(update (find t key))
end

module With_fold = struct
  module Key = struct
    type ('a, 'b) t =
      { key : 'b With_default.Key.t
      ; f : 'b -> 'a -> 'b
      }

    let create ~init ~f ~name sexp_of =
      { f; key = With_default.Key.create ~default:init ~name sexp_of }
    ;;

    let id t = With_default.Key.id t.key
  end

  let find t { Key.key; f = _ } = With_default.find t key
  let set t ~key:{ Key.key; f = _ } ~data = With_default.set t ~key ~data
  let change t { Key.key; f = _ } ~f:update = With_default.change t key ~f:update

  let add t ~key:{ Key.key; f } ~data =
    With_default.change t key ~f:(fun acc -> f acc data)
  ;;
end

module Multi = struct
  open With_fold

  module Key = struct
    type 'a t = ('a, 'a list) Key.t

    let create ~name sexp_of =
      Key.create ~init:[] ~f:(fun xs x -> x :: xs) ~name (List.sexp_of_t sexp_of)
    ;;

    let id = With_fold.Key.id
  end

  let set = set
  let find = find
  let add = add
  let change = change
end
