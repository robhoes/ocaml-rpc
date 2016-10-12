open Idl
open Rpc
open Example3_idl

module PCmdGen = Cmdlinergen.Gen ()
module DCmdGen = Cmdlinergen.Gen ()

module PClient=Datapath(GenClient)
module PCmds=Datapath(PCmdGen)
module DClient=Data(GenClient)
module DCmds=Data(DCmdGen)


module C = Codegen.Gen ()
module CD = Datapath(C)
module D = Codegen.Gen ()
module DD = Data(D)

let generate_md () =
  let interfaces = Codegen.Interfaces.empty "SMAPIv3" "Storage APIs version 3"
      "This set of interfaces is the third example of how to use the ocaml-rpc
library as an IDL to describe RPCs. This example is inspired by the
xapi-storage repository under the xapi-project organisation on github."
  in
  let interfaces =
    interfaces
    |> Codegen.Interfaces.add_interface (C.get_interface ())
    |> Codegen.Interfaces.add_interface (D.get_interface ())
  in
  let write fname str =
    let oc = open_out fname in
    Printf.fprintf oc "%s" str;
    close_out oc
  in

  Markdowngen.to_string interfaces |> write "smapi.md";
  ()

let default_cmd =
  let doc = "a cli for an API" in
  Cmdliner.Term.(ret (const (fun _ -> `Help (`Pager, None)) $ const ())),
  Cmdliner.Term.info "cli" ~version:"1.6.1" ~doc

let generate_md_cmd =
  let doc = "Generate Markdown for the interfaces" in
  Cmdliner.Term.(const generate_md $ const ()),
  Cmdliner.Term.info "markdown" ~doc

(* Use a binary 16-byte length to frame RPC messages *)
let binary_rpc path (call: Rpc.call) : Rpc.response =
  let sockaddr = Unix.ADDR_UNIX path in
  let s = Unix.socket Unix.PF_UNIX Unix.SOCK_STREAM 0 in
  Unix.connect s sockaddr;
  let ic = Unix.in_channel_of_descr s in
  let oc = Unix.out_channel_of_descr s in
  let msg_buf = Jsonrpc.string_of_call call in
  let len = Printf.sprintf "%016d" (String.length msg_buf) in
  output_string oc len;
  output_string oc msg_buf;
  flush oc;
  let len_buf = String.make 16 '\000' in
  really_input ic len_buf 0 16;
  let len = int_of_string len_buf in
  let msg_buf = String.make len '\000' in
  really_input ic msg_buf 0 len;
  let (response: Rpc.response) = Jsonrpc.response_of_string msg_buf in
  response

(*let server_cmd =
  let doc = "Start the server" in
  Cmdliner.Term.(const Example2_server.start_server $ const ()),
  Cmdliner.Term.info "server" ~doc*)

let cli () =
  let rpc = binary_rpc "path" in
  Cmdliner.Term.eval_choice default_cmd (generate_md_cmd :: (List.map (fun t -> t rpc) (!PCmdGen.terms @ !DCmdGen.terms)))

let _ = cli ()
