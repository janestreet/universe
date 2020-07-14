open! Core_kernel
open! Import

type t = string [@@deriving quickcheck, sexp_of]

module Compare_sexps : sig
  type nonrec t = t [@@deriving compare]
end
