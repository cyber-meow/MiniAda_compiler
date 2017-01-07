
(* Analyseur lexical pour Mini-Ada  *)

{
  open Lexing
  open Ast
  open Parser

  exception Lexing_error of string

  let kwd_list =
  [
    "with", WITH ; "use", USE ; "begin", BEGIN ;
    "end", END ; "procedure", PROCEDURE ; "is", IS ;
    "function", FUNCTION ; "in", IN ; "out", OUT ;
    "return", RETURN ; "type", TYPE ; "record", RECORD ;
    "access", ACCESS ; "new", NEW ; "if", IF ;
    "then", THEN ; "elsif", ELSIF; "else", ELSE ;
    "for", FOR ; "loop", LOOP ; "reverse", REVERSE ; 
    "while", WHILE ; "and", AND ; "or", OR ; 
    "not", NOT ; "rem", REM ; "null", CST(Cnull);
    "true", CST(Cbool true) ; "false", CST(Cbool false) ;
  ]

  let kwd_tbl = ((Hashtbl.create 1000) : (string, token) Hashtbl.t)
  let () = List.iter (fun (str,tok) -> Hashtbl.add kwd_tbl str tok) kwd_list

  let integer_bound = 2147483648 (* 2**31 *)
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let number = digit+
let character = ['\x00' - '\x7f']
let identifier = letter (letter | digit | '_')*
let newline = '\n' | '\r' '\n'
let space = ' ' | '\t'
let comment = "--" [^'\n' '\r']*

rule token = parse
  | newline { new_line lexbuf; token lexbuf }
  | (space|comment)+    
            { token lexbuf }
  | "+"     { PLUS }
  | "-"     { MINUS }
  | "*"     { TIMES }
  | "/"     { DIV }
  | ">"     { CMPI Bgt }
  | ">="    { CMPI Bge }
  | "<"     { CMPI Blt }
  | "<="    { CMPI Ble }
  | "="     { CMPG Beq }
  | "/="    { CMPG Bneq }
  | ","     { COMMA }
  | ":"     { COLON }
  | ";"     { SEMICOL }
  | "."     { DOT }
  | ".."    { DOTDOT }
  | "'"     { APOSTROPHE }
  | ":="    { EQUAL }
  | "("     { LPAREN }
  | ")"     { RPAREN }
  (* En général, un compileur ada ne connaît pas non plus 2**31, mais bon *)
  | number as num       
            { let n = int_of_string num in
              if n > integer_bound then
              raise (Lexing_error("value not in range of Integer: " ^ num));
              CST (Cint n) }
  | ''' (character as chr) '''
            { CST (Cchar chr) }
  | identifier as s
            { let s = String.lowercase_ascii s in
              try Hashtbl.find kwd_tbl s with Not_found -> IDENT s }
  | eof     { EOF }
  | _ as c  { raise (Lexing_error("illegal character: " ^ String.make 1 c))}



