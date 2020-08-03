(lang dune 2.0)
(name janestreet-universe)

(generate_opam_files true)

(package
 (name janestreet-universe)
 (depends
   (ocaml (>= 4.09.0))
    js_of_ocaml-ppx
    js_of_ocaml
    lambdasoup
    faraday
    angstrom
    inotify
    pyml
    cryptokit
    notty
    ppxlib))
