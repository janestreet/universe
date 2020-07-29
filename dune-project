(lang dune 2.0)
(name juniverse)

(generate_opam_files true)

(package
 (name juniverse)
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
