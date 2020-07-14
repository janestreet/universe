open! Base
open! Hardcaml_waveterm

let%expect_test "Marshall should be equal when it doesnt contain Custom wave formats." =
  let waves = Example.testbench () in
  let tmp = Caml.Filename.temp_file "waveform" "" in
  Waveform.Serialize.marshall waves tmp;
  let waves' = Waveform.Serialize.unmarshall tmp in
  assert (Waveform.equal waves waves')
;;
