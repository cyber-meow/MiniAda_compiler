
(* La phase production de l'assembleur du projet *)

open Format
open X86_64
open Ast
open Ast_kai


let pushn n = subq (imm n) (reg rsp) 
let popn n = addq (imm n) (reg rsp)

(* comment une constante est représenté dans la mémoire *)
let constant_val = function
  | Cint a -> a
  | Cchar c -> int_of_char c
  | Cbool b when b -> 1
  | _ -> 0

let funname fid = "fun" ^ (string_of_int fid)


(* on calcule la valeur de l'expression et le résultat est mis dans
   le registre rdi, dans les deux cas record et access, en fait 
   il s'agit plutôt de l'adresse de l'objet *)

let rec compile_expr = function
  
  | KEconst c -> movq (imm (constant_val c)) (reg rdi)
  
  | KEacc ac -> begin match ac with
      | KArecord (e, _) -> compile_expr e
      | KAacc (e, offset, _) ->
          compile_expr e ++
          movq (ind ~ofs:offset rdi) (reg rdi)
      | KAvar x -> 
          movq (ind ~ofs:(-x.level*8) rbx) (reg rsi) ++
          movq (ind ~ofs:x.offset rsi) (reg rdi) ++
          if x.by_ref then movq (ind rdi) (reg rdi) else nop end

  | KEnew rp ->
      newrecord rp ++ popq rdi

  | KEcall (fid, el) -> 
      let compile_arg e argcode =
        argcode ++ (compile_expr e) ++ pushq (reg rdi) in
      List.fold_right compile_arg el nop ++
      call (funname fid) ++
      popn (8 * (List.length el)) ++
      movq (reg rax) (reg rdi)
  
  | _ -> failwith "no implementation error"

(* La fonction qui, étant donné la composition des champs d'un type 
   enregistrement, construit une instance fraîche de ce type et
   empiler l'addresse de cette dernière sur la pile *)

and newrecord rp = 

  let addnewchamp (ofs, leftcode) typroc =
    let code = match typroc with
      | TPrecord rp ->
          newrecord rp ++ 
          popq rdx ++
          movq (ind rsp) (reg rcx) ++ 
          movq (reg rdx) (ind ~ofs rcx)
      | _ -> nop 
    in ofs + 8, leftcode ++ code
  in
  let frame_size, rpcode = List.fold_left addnewchamp (0, nop) rp in

  movq (imm frame_size) (reg rdi) ++
  call "malloc" ++
  pushq (reg rax) ++
  rpcode


(* compiler une instruction, son code est ajouté après codeins *)

let rec compile_inst retcode codeins = function
  
  | KIset (ac, e) -> codeins ++ begin match ac with
      | KAvar x -> 
          compile_expr e ++
          movq (ind ~ofs:(-x.level*8) rbx) (reg rsi) ++ (
          if x.by_ref then movq (ind ~ofs:x.offset rsi) (reg rsi) 
          else addq (imm x.offset) (reg rsi)) ++
          movq (reg rdi) (ind rsi)
      | KArecord (e_rec, rp) ->
          compile_expr e_rec ++
          pushq (reg rdi) ++
          compile_expr e ++
          pushq (reg rdi) ++
          copyrecord rp
      | KAacc (e_ac, ofs, typroc) -> compile_expr e_ac ++ match typroc with 
          | TPvar ->
              pushq (reg rdi) ++
              compile_expr e ++
              popq rsi ++
              movq (reg rdi) (ind ~ofs rsi)
          | TPrecord rp ->
              pushq (ind ~ofs rdi) ++
              compile_expr e ++
              pushq (reg rdi) ++
              copyrecord rp end

  | KIcall (fid, el) ->
      let compile_arg e argcode = 
        argcode ++ (compile_expr e) ++ pushq (reg rdi) in
      codeins ++
      List.fold_right compile_arg el nop ++
      call (funname fid) ++
      popn (8 * (List.length el))
  
  | KIput e -> 
      let e_code = compile_expr e in
      codeins ++ e_code ++ call "put"
  
  | KInewline -> codeins ++ call "newline"
  
  | KIret e_o ->
      let coderax = match e_o with
        | Some e -> compile_expr e ++ movq (reg rdi) (reg rax)
        | _ -> nop in
      codeins ++ coderax ++ retcode ++ ret

  | KIbloc i_l -> 
      codeins ++ List.fold_left (compile_inst retcode) codeins i_l
  
  | _ -> failwith "no imple err"

(* la fonction pour l'affectation rec1 := rec2, les addresses de rec1
   et rec2 sont sur le sommet de la pile (rec1 puis rec2), et on
   dépile à la fin *)

and copyrecord rp =

  let copychamp (ofs, leftcode) typroc =
    let precode = 
      movq (ind rsp) (reg rdi) ++
      movq (ind ~ofs:8 rsp) (reg rsi) in
    let code = match typroc with  
      | TPvar -> 
          movq (ind ~ofs rdi) (reg rdx) ++
          movq (reg rdx) (ind ~ofs rsi)
      | TPrecord rp ->
          pushq (ind ~ofs rsi) ++
          pushq (ind ~ofs rdi) ++
          copyrecord rp in
    ofs + 8, leftcode ++ precode ++ code
  in
  let _, rpcode = List.fold_left copychamp (0, nop) rp in
  rpcode ++ popn 16


(* compiler une déclaration de fonction/procédure (avec des étiquettes) *)

let compile_fun codefun f =

  let flvlofs = -(f.flevel+1)*8 in
  let ret_code = 
    popn f.frame_size ++ popq rbp ++ 
    movq (reg rbp) (ind ~ofs:flvlofs rbx) ++ popq rbp in
  let body_code = compile_inst ret_code nop f.body in
  let code = 
    label (funname f.fid) ++
    pushq (reg rbp) ++
    pushq (ind ~ofs:flvlofs rbx) ++
    movq (reg rsp) (reg rbp) ++
    movq (reg rbp) (ind ~ofs:flvlofs rbx) ++
    pushn f.frame_size ++
    body_code ++
    if f.ret then nop else ret_code ++ ret
  in codefun ++ code


(* Les codes pour les deux fonctions put et newline *)

let put_code = 
  label "put" ++
  movq (reg rdi) (reg rsi) ++
  movq (ilab "put_msg") (reg rdi) ++
  xorq (reg rax) (reg rax) ++
  call "printf" ++
  ret

let newline_code =
  label "newline" ++
  movq (ilab "newline_msg") (reg rdi) ++
  xorq (reg rax) (reg rax) ++
  call "printf" ++
  ret


(* Compiler le programe entier, le code assembleur est alors 
   écrit dans le fichier ofile *)

let compile_program file ofile =
  let ret_code = 
    popn (file.frame_size + 8 * file.max_lvl) ++
    xorq (reg rax) (reg rax) in
  let funs_code = List.fold_left compile_fun nop file.funs in
  let ibloc_code = compile_inst ret_code nop file.ibloc in
  let prog = 
    { text = 
        glabel "main" ++
        movq (reg rsp) (reg rbx) ++
        pushn (8 * file.max_lvl) ++
        movq (reg rsp) (reg rbp) ++
        movq (reg rbp) (ind ~ofs:(-8) rbx) ++
        pushn file.frame_size ++
        ibloc_code ++ (
        if file.ret then nop else ret_code ++ ret) ++
        put_code ++ newline_code ++ funs_code ;
      data = 
        label "put_msg" ++ string "%c" ++ label "newline_msg" ++ string "\n" }
  in
  let f = open_out ofile in
  let fmt = formatter_of_out_channel f in
  X86_64.print_program fmt prog ;
  fprintf fmt "@?" ;
  close_out f

