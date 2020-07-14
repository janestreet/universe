open! Core_kernel
open! Import

type t = string [@@deriving sexp_of]

let does_parse s = Parsexp.Many.parse_string s |> Result.is_ok

let quickcheck_generator =
  Quickcheck.Generator.recursive_union
    [ [%quickcheck.generator: Atom_string.t] ]
    ~f:(fun self ->
      [ (match%bind.Quickcheck.Generator [%quickcheck.generator: bool] with
          | true -> self
          | false ->
            let%map.Quickcheck.Generator subsexps = Quickcheck.Generator.list self in
            String.concat ~sep:" " (List.concat [ [ "(" ]; subsexps; [ ")" ] ]))
      ])
  |> Quickcheck.Generator.filter ~f:does_parse
;;

let quickcheck_shrinker =
  Quickcheck.Shrinker.filter [%quickcheck.shrinker: string] ~f:does_parse
;;

let quickcheck_observer = Quickcheck.Observer.of_hash (module String)

module Compare_sexps = struct
  type nonrec t = t

  let compare = Comparable.lift [%compare: Sexp.t list] ~f:Parsexp.Many.parse_string_exn
end
