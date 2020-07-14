open! Core

(** Generate an RFC822-style date *)
val rfc822_date : Time.t -> string

(** Parse an RFC822-style string into a [Time.t].

    Note that if the weekday is provided, it will not be semantically validated.
*)
val of_string_exn : string -> Time.t
