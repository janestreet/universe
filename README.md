# Jane Street universe

All of our open-source packages as one monorepo.

## Creating the universe

Use this `duniverse` fork: https://github.com/snowleopard/duniverse.

```
git clone https://github.com/janestreet/universe
cd universe
duniverse init
duniverse opam-install # install dependencies that can't be built by Dune
opam install notty     # FIXME
duniverse pull
```

You can now build the universe by `dune build`.

## Manual tweaks

* https://github.com/janestreet/universe/commit/cde07734ce4cac655f3d0bf3c709b2fb0d95c95a
* https://github.com/janestreet/universe/commit/649750a1073a701e40b2f705bdc69a1a7d53722b
* https://github.com/janestreet/universe/commit/f96e3045a52250a332b135f37fab1d43601a64e8
* https://github.com/janestreet/universe/commit/9de31851a74c5aa620c09e73d8fe86629d9f86b6
* https://github.com/janestreet/universe/commit/efd558903c52ca737b12b47e38c468df22a0ff8e
* https://github.com/janestreet/universe/commit/659786589a721e00a4e162f7ae4f638f3d3b491f
* https://github.com/janestreet/universe/commit/a94d880a2cc8db744da94d64f5957017693f620f
* https://github.com/janestreet/universe/commit/16578025728411268522a1d6ca37bd6fef815e2e
* https://github.com/janestreet/universe/commit/84f8a97cad244546272a8c432b0e592af0101af8
* https://github.com/janestreet/universe/commit/88b918b1ab7ffce07ba87480aaf65db86b9af926
* https://github.com/janestreet/universe/commit/b6955d0496030d2a5eb80665321586004762cc6c
* https://github.com/janestreet/universe/commit/df0f24934a22be30992f33c3042519a69387c6c2
