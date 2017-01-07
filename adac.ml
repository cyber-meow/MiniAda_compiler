
(* Compilateur du Mini-Ada *)

open Format
open Lexing


(* Faire seulement l'analyse syntaxique / typage *)
let parse_only = ref false
let type_only = ref false

(* Fichiers sources et cibles *)
let ifile = ref ""

let set_file f s = f := s

(* Les options du compliateur, adab --help *)
let options =
  [ "--parse-only", Arg.Set parse_only, " parsing only" ;
    "--type-only", Arg.Set type_only, " typing only" ]

let usage = "usage: adac [option] file.adb"

(* Localiser une erreur *)
let localisation pos =
  let l = pos.pos_lnum in
  let c = pos.pos_cnum - pos.pos_bol + 1 in
  eprintf "File \"%s\", line %d, characters %d-%d:\n" !ifile l (c-1) c


let main() =
  
  (* Command line parsing *)
  Arg.parse options (set_file ifile) usage;
  
  if !ifile = "" then begin eprintf 
    "input file name missing\ntry \"adac --help\" for more information.@.";
    exit 1 end;
  
  if not (Filename.check_suffix !ifile ".adb") then begin
    eprintf ".adb extension expected@.";
    Arg.usage options usage; exit 1 end;

  let f = open_in !ifile in
  let buf = Lexing.from_channel f in

  try

    let ast = Parser.file Lexer.token buf in
    close_in f;
    
    if !parse_only then exit 0 ;

    let ast_kai = Typing.check_type ast in
    let f' = open_out "out.txt" in
    let fmt = formatter_of_out_channel f' in
    Ast_printer.print_file fmt ast_kai ;
    close_out f' ;

    if !type_only then exit 0
  
  with

    | Lexer.Lexing_error msg ->
        localisation (Lexing.lexeme_start_p buf);
        eprintf "%s@." msg;
        exit 1
    | Parser.Error ->
        localisation (Lexing.lexeme_start_p buf);
        eprintf "syntax error@.";
        exit 1
    | Typing_error.Typing_error_loc (l, s, f, msg) ->
        eprintf "File \"%s\", line %d, characters %d-%d:\n" !ifile l s f;
        eprintf "%s@." msg;
        exit 1
        

let () = main()
