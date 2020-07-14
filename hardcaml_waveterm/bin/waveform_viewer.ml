open Core

let () =
  Command.basic
    ~summary:"Display a hardcaml waveform from a waveform binary dump."
    [%map_open.Command
      let filename = anon ("filename" %: string) in
      fun () ->
        let waveform = Hardcaml_waveterm.Waveform.Serialize.unmarshall filename in
        Hardcaml_waveterm_interactive.run waveform]
  |> Command.run
;;
