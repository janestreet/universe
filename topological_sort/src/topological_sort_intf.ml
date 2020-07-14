open! Import

module type Node = sig
  type t [@@deriving sexp_of]

  include Equal.S with type t := t
  include Hashtbl.Key.S with type t := t
end

module type Topological_sort = sig
  module type Node = Node

  module Edge : sig
    type 'a t =
      { from : 'a
      ; to_ : 'a
      }
    [@@deriving sexp_of]
  end

  module What : sig
    type t =
      | Nodes
      | Nodes_and_edge_endpoints
    [@@deriving sexp_of]
  end

  (** [sort (module Nodes) ~what ~nodes ~edges] returns a list of nodes [output]
      satisfying:

      - [output] contains one occurrence of every node in [nodes] when [what = Nodes],
        or one occurrence of every node in [nodes] and [edges] when
        [what = Nodes_and_edge_endpoints].
      - if [{ from; to_ }] is in [edges], then [from] occurs before [to_] in [output].
      - nodes that have no incoming or outgoing edges appear sorted at the end of
        [output].

      [sort] returns [Error] if there is a cycle. *)
  val sort
    :  ?verbose:bool (** default is [false] *)
    -> (module Node with type t = 'node)
    -> what:What.t
    -> nodes:'node list
    -> edges:'node Edge.t list
    -> 'node list Or_error.t
end
