
(* La phase production de l'assembleur du projet *)

open Format
open X86_64
open Ast
open Ast_kai


let pushn n = subq (imm n) (reg rsp) 
let popn n = addq (imm n) (reg rsp)

let andthen_counter = let i = ref (-1) in fun() -> incr i; !i
let orelse_counter = let i = ref (-1) in fun() -> incr i; !i
let cmprec_counter = let i = ref (-1) in fun() -> incr i; !i

let ifelse_counter = let i = ref (-1) in fun() -> incr i; !i
let endif_counter = let i = ref (-1) in fun() -> incr i; !i
let for_counter = let i = ref (-1) in fun() -> incr i; !i
let while_counter = let i = ref (-1) in fun() -> incr i; !i

let labname lab num = lab ^ (string_of_int num)


(* comment une constante est représenté dans la mémoire *)

let constant_val = function
  | Cint a -> a
  | Cchar c -> int_of_char c
  | Cbool b when b -> 1
  | _ -> 0


let cmp_lis = [ Beq, sete ; Bneq, setne ; Blt, setl ; 
                Ble, setle ; Bgt, setg ; Bge, setge ]

(* on calcule e1 binop e2, e1 dans %rdi et e2 dans %rsi, le 
  résultat est mis dans %rdi, les cas andthen et orelse ne
  sont pas traités ici *)

let binopcode = function

  | Bplus -> addl (reg esi) (reg edi)
  | Bminus -> subl (reg esi) (reg edi)
  | Bmul -> imull (reg esi) (reg edi)
  | Band -> andq (reg rsi) (reg rdi)
  | Bor -> orq (reg rsi) (reg rdi)
  | Bdiv -> 
      movl (reg edi) (reg eax) ++ cltd ++ 
      idivl (reg esi) ++ movl (reg eax) (reg edi)
  | Brem ->
      movl (reg edi) (reg eax) ++ cltd ++ 
      idivl (reg esi) ++ movl (reg edx) (reg edi)
  | Beq | Bneq as cmp_op ->
      cmpq (reg rsi) (reg rdi) ++
      (List.assoc cmp_op cmp_lis) (reg dil) ++
      movzbq (reg dil) rdi
  | cmp_op ->
      cmpl (reg esi) (reg edi) ++
      (List.assoc cmp_op cmp_lis) (reg dil) ++
      movzbq (reg dil) rdi



(* La fonction qui, étant donné la composition des champs d'un type 
   enregistrement, construit une instance fraîche de ce type et
   empiler l'addresse de cette dernière sur la pile *)

let rec newrecord rp = 

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
  pushq (reg rax) ++ rpcode

  
(* teste si deux enregistrements sont égaux, et fait andq res %rdi,
   les addresses des deux enregistrements sont sur le sommet de la pile, 
   on dépile à la fin *)

let rec cmprecord rp = 

  let cmpid = cmprec_counter() in
  let cmpchamp (ofs, leftcode) typroc =
    let precode = 
      testq (reg rdi) (reg rdi) ++
      jz (labname "endcmprec" cmpid) ++
      movq (ind rsp) (reg rdx) ++
      movq (ind ~ofs:8 rsp) (reg rcx) in
    let code = match typroc with
      | TPvar ->
          movq (ind ~ofs rdx) (reg rdx) ++
          cmpq (reg rdx) (ind ~ofs rcx) ++
          sete (reg dil) ++
          movzbq (reg dil) rdi
      | TPrecord rp ->
          pushq (ind ~ofs rcx) ++
          pushq (ind ~ofs rdx) ++
          cmprecord rp in
    ofs + 8, leftcode ++ precode ++ code
  in
  let _, rpcode = List.fold_left cmpchamp (0, nop) rp in
  label (labname "cmprec" cmpid) ++ rpcode ++ 
  label (labname "endcmprec" cmpid) ++ popn 16


(* la fonction pour l'affectation rec1 := rec2, les addresses de rec1
   et rec2 sont sur le sommet de la pile (rec1 puis rec2), et on
   dépile à la fin *)

let rec copyrecord rp =

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
  
  (* L'adresse d'une variable (où le contenu de x est stocké), 
     sauf pour record c'est tjs l'adresse de record *)
  | KEaddr ac -> begin match ac with
      | KArecord (e, _) -> compile_expr e
      | KAvar x ->
          movq (ind ~ofs:(-x.level*8) rbx) (reg rsi) ++
          if x.by_ref then movq (ind ~ofs:x.offset rsi) (reg rdi)
          else leaq (ind ~ofs:x.offset rsi) rdi
      | KAacc (e, ofs, typroc) -> compile_expr e ++ match typroc with
          | TPvar -> addq (imm ofs) (reg rdi)
          | TPrecord _ -> movq (ind ~ofs rdi) (reg rdi) end

  | KEbinop (o, e1, e2) -> begin match o with
      | Bandthen ->
          let andthenid = andthen_counter() in
          compile_expr e1 ++
          testq (reg rdi) (reg rdi) ++
          jz (labname "endandthen" andthenid) ++
          compile_expr e2 ++
          label (labname "endandthen" andthenid) 
      | Borelse ->
          let orelseid = orelse_counter() in
          compile_expr e1 ++
          testq (reg rdi) (reg rdi) ++
          jnz (labname "endorelse" orelseid) ++
          compile_expr e2 ++
          label (labname "endorelse" orelseid) 
      | _ ->
          compile_expr e2 ++
          pushq (reg rdi) ++
          compile_expr e1 ++
          popq rsi ++ binopcode o end

  | KErecbinop (o, e1, e2, rp) ->
      compile_expr e1 ++
      pushq (reg rdi) ++
      compile_expr e2 ++
      pushq (reg rdi) ++
      movq (imm 1) (reg rdi) ++
      cmprecord rp ++ begin match o with
        | Beq -> nop
        | Bneq -> notq (reg rdi) ++ andq (imm 1) (reg rdi)
        | _ -> assert false end

  | KEunop (o, e) -> compile_expr e ++ begin match o with
      | Unot -> notq (reg rdi) ++ andq (imm 1) (reg rdi)
      | Uneg -> negl (reg edi) end

  | KEnew rp ->
      newrecord rp ++ popq rdi

  | KEcall (fid, el) -> 
      let compile_arg e argcode =
        argcode ++ (compile_expr e) ++ pushq (reg rdi) in
      List.fold_right compile_arg el nop ++
      call (labname "fun" fid) ++
      popn (8 * (List.length el)) ++
      movq (reg rax) (reg rdi)
  


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
      call (labname "fun" fid) ++
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
  
  | KIif (ci_l, elbloc) ->
      let ifid = endif_counter() in
      let ifelsecode (cond, inst) elsecode =
        let ifelseid = ifelse_counter() in
        compile_expr cond ++
        testq (reg rdi) (reg rdi) ++
        jz (labname "else" ifelseid) ++
        (* ça sert juste pour la lisibilité *)
        label (labname "if" ifelseid) ++
        compile_inst retcode nop inst ++
        jmp (labname "endif" ifid) ++
        label (labname "else" ifelseid) ++
        elsecode
      in
      let elsecode = compile_inst retcode nop elbloc in
      codeins ++ 
      List.fold_right ifelsecode ci_l elsecode ++
      label (labname "endif" ifid)

  | KIfor (ofs, rev, eg, ed, inst) ->
      let forid = for_counter() in
      let code =
        compile_expr (if rev then ed else eg) ++
        (* movq (reg rdi) (ind ~ofs rbp) *)
        pushq (reg rdi) ++
        compile_expr (if rev then eg else ed) ++
        (* = movq (reg rdi) (ind ~ofs:(ofs-8) rbp) *)
        pushq (reg rdi) ++
        jmp (labname "fordown" forid) ++
        label (labname "forup" forid) ++
        compile_inst retcode nop inst ++
        (* = incq (ind ~ofs:8 rsp) *)
        (if rev then decl else incl) (ind ~ofs rbp) ++
        label (labname "fordown" forid) ++
        movl (ind ~ofs rbp) (reg edi) ++
        cmpl (ind ~ofs:(ofs-8) rbp) (reg edi) ++
        (if rev then jge else jle) (labname "forup" forid) ++ 
        popn 16
      in codeins ++ code

  | KIwhile (cond, inst) -> 
      let whileid = while_counter() in
      let code = 
        jmp (labname "whiledown" whileid) ++
        label (labname "whileup" whileid) ++
        compile_inst retcode nop inst ++
        label (labname "whiledown" whileid) ++
        compile_expr cond ++
        testq (reg rdi) (reg rdi) ++
        jnz (labname "whileup" whileid) 
      in codeins ++ code



(* compiler une déclaration de fonction/procédure (avec des étiquettes) *)

let compile_fun codefun f =

  let flvlofs = -(f.flevel+1)*8 in
  let ret_code = 
    popn f.frame_size ++ popq rbp ++ 
    movq (reg rbp) (ind ~ofs:flvlofs rbx) ++ popq rbp in
  let body_code = compile_inst ret_code nop f.body in
  let code = 
    label (labname "fun" f.fid) ++
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

