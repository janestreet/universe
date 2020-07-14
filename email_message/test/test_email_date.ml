open! Core
open Email_message
open Expect_test_helpers_core
open Email_date

let parse_and_print time =
  print_string (Time.to_string_iso8601_basic (of_string_exn time) ~zone:Time.Zone.utc)
;;

let%expect_test "of_rfc822_date neg offset" =
  parse_and_print "Fri, 03 Dec 2010 16:02:30 -0600 (CST)";
  [%expect {| 2010-12-03T22:02:30.000000Z |}]
;;

let%expect_test "of_rfc822_date GMT" =
  parse_and_print "Fri, 3 Dec 2010 16:02:30 +0000 (GMT)";
  [%expect {| 2010-12-03T16:02:30.000000Z |}]
;;

let%expect_test "of_rfc822_date pos offset" =
  parse_and_print "Fri, 03 Dec 2010 16:02:30 +0600 (BST)";
  [%expect {| 2010-12-03T10:02:30.000000Z |}]
;;

let%expect_test "of_rfc822_date seconds are optional" =
  parse_and_print "Fri, 03 Dec 2010 16:02 +0600 (BST)";
  [%expect {| 2010-12-03T10:02:00.000000Z |}]
;;

let%expect_test "of_rfc822_date 2 digit year meaning 20th century (obsolete format)" =
  parse_and_print "01 Jan 98 11:00 +0000";
  [%expect {| 1998-01-01T11:00:00.000000Z |}]
;;

let%expect_test "of_rfc822_date 2 digit year meaning 21st century (obsolete format)" =
  parse_and_print "01 Jan 20 11:00 +0000";
  [%expect {| 2020-01-01T11:00:00.000000Z |}]
;;

let%expect_test "of_rfc822_date embedded comments and extra whitespace" =
  parse_and_print "  Fri,   (hello) 03 Dec 2010 16:02:30 (BST)\n+0600";
  [%expect {| 2010-12-03T10:02:30.000000Z |}]
;;

let%expect_test "of_rfc822_date no day-of-week" =
  parse_and_print "03 Dec 2010 16:02:30 +0600 (BST)";
  [%expect {| 2010-12-03T10:02:30.000000Z |}]
;;

let%expect_test "of_rfc822_date obsolete timezones" =
  List.iter
    [ "UT"; "GMT"; "EST"; "EDT"; "CST"; "CDT"; "MST"; "MDT"; "PST"; "PDT" ]
    ~f:(fun tz ->
      parse_and_print ("03 Dec 2010 16:02:30 " ^ tz);
      Out_channel.newline stdout);
  [%expect
    {|
    2010-12-03T16:02:30.000000Z
    2010-12-03T16:02:30.000000Z
    2010-12-03T21:02:30.000000Z
    2010-12-03T20:02:30.000000Z
    2010-12-03T22:02:30.000000Z
    2010-12-03T21:02:30.000000Z
    2010-12-03T23:02:30.000000Z
    2010-12-03T22:02:30.000000Z
    2010-12-04T00:02:30.000000Z
    2010-12-03T23:02:30.000000Z |}]
;;

(* As per https://tools.ietf.org/html/rfc5322#section-4.3 all these military timezones are
   unpredictable and hence should be parsed as '-0000' *)
let%expect_test "of_rfc822_date military timezones" =
  let single_letter_tzs =
    List.init 26 ~f:(fun i -> Char.of_int_exn (Char.to_int 'A' + i) |> Char.to_string)
    |> List.filter ~f:(String.( <> ) "J")
  in
  let parsed =
    List.map single_letter_tzs ~f:(fun tz ->
      of_string_exn ("Fri, 03 Dec 2010 16:02:30 " ^ tz))
  in
  print_string (Time.to_string_iso8601_basic (List.hd_exn parsed) ~zone:Time.Zone.utc);
  List.iter parsed ~f:(fun time ->
    require_equal [%here] (module Time) (List.hd_exn parsed) time);
  [%expect {| 2010-12-03T16:02:30.000000Z |}]
;;

let%expect_test "of_rfc822_date fail semantically incorrect date" =
  show_raise (fun () -> of_string_exn "Fri, 39 Dec 2010 16:02:30 +0000 (GMT)");
  [%expect
    {|
    (raised (
      Invalid_argument
      "Date.create_exn ~y:2010 ~m:Dec ~d:39 error: 31 day month violation")) |}]
;;

let%expect_test "of_rfc822_date fail bad format" =
  show_raise (fun () -> of_string_exn "bad format");
  [%expect {| (raised (Failure "Failed to parse RFC822 date > day: skip")) |}]
;;

let%expect_test "of_rfc822_date fail no TZinfo" =
  show_raise (fun () -> of_string_exn "Fri, 03 Dec 2010 16:02:30 (BST)");
  [%expect {| (raised (Failure "Failed to parse RFC822 time zone: no more choices")) |}]
;;

let%expect_test "of_rfc822_date semantically invalid UTC offset" =
  show_raise (fun () -> of_string_exn "Fri, 03 Dec 2010 16:02:30 -3600 (CST)");
  [%expect {| (raised "The supplied UTC offset is semantically invalid.") |}]
;;

let%expect_test "rfc822_date" =
  print_string (Email_date.rfc822_date Time.epoch);
  [%expect {| Wed, 31 Dec 1969 19:00:00 -0500 |}]
;;

let%test_unit ("rfc822_date round-trip"[@tags "64-bits-only"]) =
  let open! Quickcheck.Let_syntax in
  Quickcheck.test
    (* Unfortunately we cannot use Time.quickcheck_generator since that generates times
       with sub-second precision and a RFC822 date is only precise to the second.

       unix time 3_000_000_000 is in the year 2065.
    *)
    (let%map seconds_since_epoch = Int64.gen_incl (-100L) 3_000_000_000L in
     Float.of_int64 seconds_since_epoch |> Time.Span.of_sec |> Time.of_span_since_epoch)
    ~sexp_of:[%sexp_of: Time.t]
    ~f:(fun time ->
      [%test_eq: Time.t] time (Email_date.rfc822_date time |> of_string_exn))
;;
