
open Format
open Ast
open Ast_kai

let print_const fmt = function
  | Cnull -> fprintf fmt "Cnull"
  | Cint a -> fprintf fmt "Cint %d" a
  | Cbool b -> 
      let b_msg = if b then "true" else "false" in
      fprintf fmt "Cbool %s" b_msg
  | Cchar c -> fprintf fmt "Cchar %c" c

let binop_list = 
  [ Bplus, "Bplus"; Bminus, "Bminus"; Bmul, "Bmul"; Bdiv, "Bdiv";
    Brem, "Brem"; Beq, "Beq"; Bneq, "Bneq"; Blt, "Blt"; Ble, "Ble"; 
    Bgt, "Bgt"; Bge, "Bge"; Band, "Band"; Bandthen, "Bandthen";
    Bor, "Bor"; Borelse, "Borelse" ]

let print_binop fmt op = fprintf fmt "%s" (List.assoc op binop_list)

let print_unop fmt = function
  | Unot -> fprintf fmt "Unot"
  | Uneg -> fprintf fmt "Uneg"

let print_id fmt idk = 
  let b_msg = if idk.by_ref then "true" else "false" in
  fprintf fmt "{ level = %d; offset = %d; by_ref = %s }" 
    idk.level idk.offset b_msg

let rec print_typrod fmt = function
  | TPvar -> fprintf fmt "TPvar"
  | TPrecord rp -> fprintf fmt "@[TPrecord (%a)@]" print_rp rp

and print_rp fmt lis = pp_print_list print_typrod fmt lis

let rec print_expr fmt = function
  | KEconst c -> fprintf fmt "@[KEconst (%a)@]" print_const c
  | KEacc ac -> fprintf fmt "@[KEacc (%a)@]" print_ac ac
  | KEaddr ac -> fprintf fmt "@[KEaddr (%a)@]" print_ac ac
  | KEbinop (o, e1, e2) -> 
      fprintf fmt "@[KEbinop (%a, %a, %a)@]" 
        print_binop o print_expr e1 print_expr e2
  | KEunop (o, e) -> 
      fprintf fmt "@[KEunop (%a, %a)@]" print_unop o print_expr e
  | KEnew rp -> fprintf fmt "(@[KEnew %a@])" print_rp rp
  | KEcall (fid, el) -> 
      fprintf fmt "@[KEcall (%d, %a)@]" fid (pp_print_list print_expr) el

and print_ac fmt = function
  | KAvar idk -> fprintf fmt "@[KAvar (%a)@]" print_id idk
  | KArecord (e, rp) -> 
      fprintf fmt "@[KArecord (%a, %a)@]" print_expr e print_rp rp
  | KAacc (expr_kai, offset, typrod) ->
      fprintf fmt "@[KAacc (%a, %d, %a)@]" 
        print_expr expr_kai offset print_typrod typrod

let rec print_inst fmt = function
  | KIset (ac, e) -> 
      fprintf fmt "@[KIset (%a, %a)@]" print_ac ac print_expr e
  | KIcall (fid, el) -> 
      fprintf fmt "@[KIcall (%d, %a)@]" fid (pp_print_list print_expr) el
  | KIput e -> fprintf fmt "@[KIput (%a)@]" print_expr e
  | KInewline -> fprintf fmt "KInewline"
  | KIret e_o -> begin match e_o with
      | Some e ->
          fprintf fmt "@[KIret (%a))@]" print_expr e
      | _ -> fprintf fmt "KIret" end
  | KIbloc il -> pp_print_list print_inst fmt il
  | KIif (ci_l, i) -> 
      fprintf fmt "@[KIif (%a, %a)@]" 
        (pp_print_list print_ci) ci_l print_inst i
  | KIfor (ofs, b, bg, ed, i) -> 
      let b_msg = if b then "true" else "false" in
      fprintf fmt "@[KIfor (%d, %s, %a, %a, %a)@]" 
        ofs b_msg print_expr bg print_expr ed print_inst i
  | KIwhile (cond, i) -> 
      fprintf fmt "@[KIwhile (%a, %a)@]" print_expr cond print_inst i

and print_ci fmt (cond, inst) = 
  fprintf fmt "(%a, %a)" print_expr cond print_inst inst

let print_func fmt f = 
  fprintf fmt "@[{ fid = %d; flevel = %d; frame_size = %d; body = %a }@]"
    f.fid f.flevel f.frame_size print_inst f.body

let print_file fmt (fl, i, fs, mlevel) = 
  fprintf fmt "@[fs: %a; is: %a; frsize: %d; mlevel: %d@]"
    (pp_print_list print_func) fl print_inst i fs mlevel
  
