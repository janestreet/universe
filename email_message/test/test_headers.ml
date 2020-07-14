open! Core
open Email_message
module Expect_test_config = Core.Expect_test_config

let%expect_test "whitespace" =
  let headers =
    Email_headers.of_list
      ~normalize:`None
      [ "header1", "1"
      ; "header2", " 2"
      ; "header3", "=?ISO-8859-1?Q?a?="
      ; "header4", " =?ISO-8859-1?Q?a?="
      ]
  in
  let print_headers ~normalize =
    Email_headers.to_list ~normalize headers
    |> List.iter ~f:(fun (name, value) -> printf "|%s|%s|\n" name value)
  in
  print_headers ~normalize:`None;
  [%expect
    {|
    |header1|1|
    |header2| 2|
    |header3|=?ISO-8859-1?Q?a?=|
    |header4| =?ISO-8859-1?Q?a?=| |}];
  print_headers ~normalize:`Whitespace;
  [%expect
    {|
    |header1|1|
    |header2|2|
    |header3|=?ISO-8859-1?Q?a?=|
    |header4|=?ISO-8859-1?Q?a?=| |}];
  print_headers ~normalize:`Whitespace_and_encoded_words;
  [%expect {|
    |header1|1|
    |header2|2|
    |header3|a|
    |header4|a| |}]
;;
