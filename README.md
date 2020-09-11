# Jane Street universe

All of our open-source packages as one monorepo.

## Creating the universe

Use this `duniverse` fork: https://github.com/snowleopard/duniverse.

```
git clone https://github.com/janestreet/universe
cd universe
duniverse init
# Install dependencies that can't be built by Dune
duniverse opam-install
duniverse pull
# Fix conflicts with installed libraries
rm -rf duniverse/zarith* duniverse/uuseg* duniverse/uucp* duniverse/uutf* duniverse/seq*
```

You can now build the universe by `dune build`.

## Manual tweaks

That had to be made to make the universe buildable. Our aim is to make this list
empty.

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
* https://github.com/janestreet/universe/commit/bf7630d8ac7f7bf9fd92aba4abe040b4328aef84
* https://github.com/janestreet/universe/commit/ea5f700c68c96ff97fb22fbb6460e4cdc4da7f88
* https://github.com/janestreet/universe/commit/7b2f68021e1b0839607c1fb15ee9ed48fdb71078
* https://github.com/janestreet/universe/commit/d6f42ce3b4648527d2c13f5ec47fdf9eac7f0397
* https://github.com/janestreet/universe/commit/2879e5ef23c02aaf9bfde21a779a3738a84c55d0
* https://github.com/janestreet/universe/commit/9b4253e1cb9aba4886be3dd4c82f38b7a1b05a8a
* https://github.com/janestreet/universe/commit/311099da18bf8484ed5f24c5be8990f3604ca8b3
* https://github.com/janestreet/universe/commit/4147d659de1045d0b3553ea108db92e7d4f20e70
* https://github.com/janestreet/universe/commit/ecd8e0efc23aa9b504540349a802b59564e87205
* https://github.com/janestreet/universe/commit/93898cbd7365f5f588d1dc03dba79d4dc9a9dffa
* https://github.com/janestreet/universe/commit/ae637f759821456e2f3fb2a074aa4ced2fa455b7
* https://github.com/janestreet/universe/commit/f793b5f579fd2a95d993c888e2aeb72921b407c2
* https://github.com/janestreet/universe/commit/ef84476b6b64211dbe3f29492435a429ba5b752e
* https://github.com/janestreet/universe/commit/870841d9ff84bc03ad22561f2df2eea90cbf0c09
* https://github.com/janestreet/universe/commit/abb9e922ed3438149cbe5b326d85f87a1a756fcf
* https://github.com/janestreet/universe/commit/77c2948532ad4075a199c96bbecaefe90f3738fd
* https://github.com/janestreet/universe/commit/93d29b6008a4bf4eb77f308071cd68f3782a8a2b
* https://github.com/janestreet/universe/commit/6fe9688046e60b520f07d940aa27071fc95df659
* https://github.com/janestreet/universe/commit/ab7e240674424923a3b3aa936b67b0ea3740e5e8
* https://github.com/janestreet/universe/commit/919ec805957922e8a3d244edbf5d6f8a4a19433d
* https://github.com/janestreet/universe/commit/f91a42856dfdd5f8fc2181bc18ffdd294618c277
* https://github.com/janestreet/universe/commit/86760f29b57f320558b63aceec54c1c7c99d3924
* https://github.com/janestreet/universe/commit/578e2690f7209ddf8325ce41683121931a10703a
* https://github.com/janestreet/universe/commit/62fa1273df637f3a266025a7639e91e38f979372
* https://github.com/janestreet/universe/commit/fbe8e7ba482b8cf7931c6bffd3ac348c31916922