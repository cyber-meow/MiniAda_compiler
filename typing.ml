
(* Typeur de Mini-Ada *)

open Ast
open Ast_kai
open Lexing
open Typing_error


module DImap = 
  Map.Make(struct type t = depth * ident let compare = compare end)

type nature = mode * ty
type fun_par = bool

type fun_id = int
let next_funid = let i = ref (-1) in fun () -> incr i; !i
let max_level = ref 1

(* Un identifier represente soit une fonction/procédure, soit un 
   enregistrement/access, soit une variable *)

type ty_g =
  | TGvariable of fun_par * nature (* Pour les paramètres des fonc/procs *)
  | TGrecord of depth * ident * record
  | TGaccess of depth * ident
  | TGprocedure of fun_id * args
  | TGfunction of fun_id * args * ty

and args = (ident * nature) list

(* On stocke de plus dans ndef_types la position où le type est déclaré 
   record_names c'est surtout pour access, frame_size pour for 
   Dans tbl, si le string ne correspond pas à une variable, la valeur
   de offset et de by_ref sont non-significatives *)

type env = 
  { tbl : (ident_kai * ty_g) Imap.t ; 
    record_names : record DImap.t ;
    ndef_types : location Imap.t ;
    depth : int ; 
    frame_size : int }

(* Les noms réservés, pas foecément le cas dans ada *)
let reserved_word = [ "put" ; "new_line" ; "all" ]


let eqiv_type t1 t2 = match t1,t2 with
  | Taccess _, Tnull -> true
  | Tnull, Taccess _ -> true
  | Trecord (d1, id1, _), Trecord (d2, id2, _) -> d1 = d2 && id1 = id2
  | Taccess (d1, id1), Taccess (d2, id2) -> d1 = d2 && id1 = id2
  | _, _ -> t1 = t2

(* t2 is expected to be type t1 *)
let must_be_the_same loc2 t1 t2 = 
  if not (eqiv_type t1 t2) then t_error loc2 (Type_error (t2, t1))

(* Si id n'est pas dans env, soit mot réservé, soit pas déclaré *)
let not_found_error loc id =
  if List.mem id reserved_word then t_error loc (Reserved_word id)
  else t_error loc (Undeclared_identifier id)


(* la nature (mode + type) d'une expression expr dans l'environnement env,
   + la nouvelle type d'expression dans l'ast_kai *)

let rec expr_type env = function

  | Econst c -> let ty = match c with 
      | Cnull -> Tnull
      | Cint _ -> Tint
      | Cbool _ -> Tbool
      | Cchar _ -> Tchar in Min, ty, KEconst c
  
  | Eacc a -> begin match a with
      | Aid idn -> 
          let loc = idn.id_loc in
          let id = idn.id in
          let a_idkai, a_tyg = Imap.find id env.tbl in begin
          try match a_tyg with
            | TGvariable (_, (mode, ty)) ->
                let a_kai = match ty with
                  | Trecord (_, _, (_, rp)) -> 
                      KArecord (KEacc (KAvar a_idkai), rp)
                  | _ -> KAvar a_idkai in
                mode, ty, KEacc a_kai
            | TGfunction (fun_id, args, r_ty) when args = [] -> 
                Min, r_ty, KEcall (fun_id, [])
            | TGfunction (_, args, _) ->
                t_error loc (Number_arguments (id, List.length args ,0))
            | TGprocedure _ -> t_error loc (Procedure_no_value id)
            | _ -> t_error loc (Not_value id)
          with Not_found -> not_found_error loc id end
      | Aacc (e, idn) ->
          (* Le cas spécial c'est f(...)._, pour gnatmake, si f renvoie
             une valeur d'un type d'accès, on peut la modifier *)
          let e_mode, e_ty, e_kai = expr_type env e.e_tree in
          match e_ty with
            | Trecord (_, r_id, (r, _)) ->
                if idn.id = "all" then 
                  t_error e.e_loc (Prefix_dereference e_ty) ; 
                begin try 
                  let id_ty, id_ofs = Imap.find idn.id r in
                  let id_typr = match id_ty with
                    | Trecord (_, _, (_, rp)) -> TPrecord rp
                    | _ -> TPvar in
                  e_mode, id_ty, KEacc (KAacc (e_kai, id_ofs, id_typr))
                with Not_found -> 
                  t_error idn.id_loc (No_field_name (idn.id, r_id)) end
            (* n'oublie pas le cas a.all *)
            | Taccess (dep, r_id) -> begin
                match e.e_tree with
                  | Enew _ -> t_error e.e_loc Prefix_selection_new 
                  | _ -> () end ;
                let r, rp = DImap.find (dep, r_id) env.record_names in
                if idn.id = "all" then 
                  Min_out, 
                  Trecord (dep, r_id, (r, rp)), 
                  KEacc (KArecord (e_kai, rp))
                else begin
                  (* si a est de type acceès, in argument, on peut 
                     quand-même modifeir a._ *)
                  try 
                    let id_ty, id_ofs = Imap.find idn.id r in
                    let id_typr = match id_ty with
                      | Trecord (_, _, (_, rp)) -> TPrecord rp
                      | _ -> TPvar in
                    Min_out, id_ty, KEacc (KAacc (e_kai, id_ofs, id_typr))
                  with Not_found -> 
                    t_error idn.id_loc (No_field_name (idn.id, r_id)) end
            | _ -> 
                if idn.id = "all" then 
                  t_error e.e_loc (Prefix_dereference e_ty)
                else t_error e.e_loc (Prefix_selection e_ty) end
  
  | Ebinop (op, e1, e2) -> 
      let _, e1_ty, e1_kai = expr_type env e1.e_tree in
      let _, e2_ty, e2_kai = expr_type env e2.e_tree in
      let ty = match op with
        | Bplus | Bminus | Bmul | Bdiv | Brem -> 
            must_be_the_same e1.e_loc Tint e1_ty ;
            must_be_the_same e2.e_loc Tint e2_ty ;
            Tint 
        | Band | Bandthen | Bor | Borelse -> 
            must_be_the_same e1.e_loc Tbool e1_ty ;
            must_be_the_same e2.e_loc Tbool e2_ty  ;
            Tbool
        | Blt | Ble | Bgt | Bge ->
            must_be_the_same e1.e_loc Tint e1_ty ;
            must_be_the_same e2.e_loc Tint e2_ty ; 
            Tbool 
        | Beq | Bneq ->
            must_be_the_same e2.e_loc e1_ty e2_ty ; 
            Tbool 
      in Min, ty, KEbinop (op, e1_kai, e2_kai)

  | Eunop (op, e) ->
      let _, e_ty, e_kai = expr_type env e.e_tree in
      let ty = match op with
        | Unot -> must_be_the_same e.e_loc Tbool e_ty ; Tbool 
        | Uneg -> must_be_the_same e.e_loc Tint e_ty ; Tint 
      in Min, ty, KEunop (op, e_kai)

  | Enew idn -> 
      let id = idn.id in
      let loc = idn.id_loc in begin
      try match snd (Imap.find id env.tbl) with
        | TGrecord (dep, r_id, (_, rp)) -> 
            if Imap.mem id env.ndef_types then t_error loc (Invalid_bfd id) ;
            Min, Taccess (dep, r_id), KEnew rp
        | _ -> t_error loc Record_required
      with Not_found -> not_found_error loc id end

  | Ecall (f, el) -> 
      let id = f.id in
      let loc = f.id_loc in begin
      try match snd (Imap.find id env.tbl) with
        | TGfunction (fun_id, args, r_ty) -> 
            let aslen = List.length args in
            let eslen = List.length el in
            if aslen <> eslen then 
              t_error loc (Number_arguments (id, aslen, eslen)) ;
            let el_kai = List.map2 (verify_argument env) args el in
            Min, r_ty, KEcall (fun_id, el_kai)
        | TGprocedure _ -> t_error loc (Procedure_no_value id)
        | _ -> t_error loc (Not_applied id)
      with Not_found -> not_found_error loc id end

  | Echar'val e ->
      let _, e_ty, e_kai = expr_type env e.e_tree in
      must_be_the_same e.e_loc Tint e_ty ; Min, Tchar, e_kai

and verify_argument env arg e =
  let id, (mode, ty) = arg in
  let e_mode, e_ty, e_kai = expr_type env e.e_tree in
  must_be_the_same e.e_loc ty e_ty ;
  if mode = Min_out && e_mode = Min then t_error e.e_loc (Actual_variable id) ;
  if mode = Min_out && e_mode = Miter then t_error e.e_loc Vfor_nomodified ;
  match mode, e_kai with
    | Min_out, KEacc ac_kai -> KEaddr ac_kai
    | _ -> e_kai


(* Ajoute l'association (id_kai, id_tg) dans env.tbl,
   on fait attention à ne pas Déclarer deux fois le même nom dans
   un même niveau et à ne pas Utiliser les noms réservés

   Si ndef_types < 0 : envlève id de env.ndef_types
                 = 0 : env.ndef_types inchangé
                 > 0 : ajoute id dans env.ndef_types *)

let update env idn id_tg ndef_types =
  let id = idn.id in
  let loc = idn.id_loc in
  (* noms réservés interdits *)
  if List.mem id reserved_word then t_error loc (Reserved_word id) ;
  let ndef_types' = begin
    if Imap.mem id env.tbl then begin 
      let id_old_dep = (fst (Imap.find id env.tbl)).level in
      (* cas id déjà déclaré avant dans ce même niveau *)
      if env.depth = id_old_dep && (
          ndef_types >= 0 || not (Imap.mem id env.ndef_types))
      then t_error loc (Redefine id) end ;
    if ndef_types > 0 then Imap.add id loc env.ndef_types
    else Imap.remove id env.ndef_types end
  in
  let record_names', frame_size', offset', by_ref = match id_tg with
    | TGvariable (fun_par, (mode, _)) -> 
        let offset', by_ref = match fun_par, mode with
          | true, Min_out -> env.frame_size, true
          | true, _ -> env.frame_size, false
          | _ -> -env.frame_size-8, false in
        env.record_names, env.frame_size + 8, offset', by_ref 
    | TGrecord (dep, r_id, reco) ->
        DImap.add (dep, r_id) reco env.record_names, env.frame_size, 0, false
    | _ -> env.record_names, env.frame_size, 0, false
  in
  let id_kai = 
    { level = env.depth ; offset = offset' ; by_ref = by_ref } in
  let tbl' =  Imap.add id (id_kai, id_tg) env.tbl in
  { tbl = tbl' ; record_names = record_names' ; 
    ndef_types = ndef_types' ; depth = env.depth ; frame_size = frame_size' }


(* Trouver le type qu'un identificateur represente 
   cas spécial: integer, character, boolean *)

let find_type_id env ty_idn =
  let ty_id = ty_idn.id in
  let ty_loc = ty_idn.id_loc in
  try match snd (Imap.find ty_id env.tbl) with
    | TGrecord (d, id, reco) -> Trecord (d, id, reco)
    | TGaccess (d, r_id) -> Taccess (d, r_id)
    | _ -> t_error ty_loc Type_required
  with Not_found -> match ty_id with
    | "integer" -> Tint
    | "character" -> Tchar
    | "boolean" -> Tbool
    | _ -> not_found_error ty_loc ty_id

(* Trouver le type qu'un 'typ' represente,
   Rec_id pour traiter les champs d'un type enregistrement *)

let find_type_typ env rec_id = function
  | Tid ty_idn ->
      if ty_idn.id = rec_id then t_error ty_idn.id_loc Refer_itself ;
      find_type_id env ty_idn
  | Tac ty_idn -> 
      if ty_idn.id = rec_id then Taccess (env.depth, rec_id)
      else match find_type_id env ty_idn with
        | Trecord (dep, r_id, _) -> Taccess (dep, r_id)
        | _ -> t_error ty_idn.id_loc Record_required


(* Dans l'environnement env, si l'instruction inst est bien typée pour
   le type de retour r_ty, see_ret pour indiquer que si return es vu ou pas.
   (en fait si see_ret = true, il faut signaler warning unreachable code)
   
   Par convention, si r_ty = Tnull, on est dans une procédure
   De toute façon une fonction ne renvoie pas le type null, mais
   il faut savoir que return null n'est pas légitime dans une procédure *)

let rec inst_type env r_ty see_ret = function

  | Iset (ac, e) ->
      let ac_mode, ac_ty, ac_exprkai = expr_type env (Eacc ac) in
      let _, e_ty, e_kai  = expr_type env e.e_tree in begin
      match ac_mode with
        | Min_out -> must_be_the_same e.e_loc ac_ty e_ty
        | Min -> t_error e.e_loc Left_hand_side
        | Miter -> t_error e.e_loc Vfor_nomodified 
      end ; begin
      match ac_exprkai with
        | KEacc ac_kai -> see_ret, KIset (ac_kai, e_kai)
        | _ -> assert false end

  | Icall (proc, el) ->
      let id = proc.id in
      let loc = proc.id_loc in begin
      match id with
        | "put" ->
            let eslen = List.length el in
            if eslen <> 1 then
              t_error loc (Number_arguments (id, 1, eslen)) ;
            let e = List.hd el in
            let _, e_ty, e_kai = expr_type env e.e_tree in
            must_be_the_same e.e_loc Tchar e_ty ;
            see_ret, KIput e_kai
        | "new_line" ->
            if el <> [] then
              (t_error loc (Number_arguments (id, 0, List.length el)));
            see_ret, KInewline
        | _ ->
            try match snd (Imap.find proc.id env.tbl) with
              | TGprocedure (proc_id, args) ->
                  let aslen = List.length args in
                  let eslen = List.length el in
                  if aslen <> eslen then
                    t_error loc (Number_arguments (id, aslen, eslen)) ;
                  let el_kai = List.map2 (verify_argument env) args el in
                  see_ret, KIcall (proc_id, el_kai)
              | TGfunction _ -> t_error loc (Function_not_procedure id)
              | _ -> t_error loc (Not_applied id) 
            with Not_found -> not_found_error loc id 
      end

  | Iret (e_o, loc) -> 
      let eo_kai = match e_o with
        | Some e ->
            if r_ty = Tnull then t_error e.e_loc Procedure_no_retv ;
            let _, e_ty, e_kai = expr_type env e.e_tree in 
            must_be_the_same e.e_loc r_ty e_ty ;
            Some e_kai
        | _ -> 
            if r_ty <> Tnull then t_error loc Missing_ret_expr ;
            None
      in true, KIret eo_kai

  | Ibloc i_l ->
      let see_ret, il_kai = List.fold_left
        (fun (see_ret, il_kai) i -> 
          let see_ret, i_kai = inst_type env r_ty see_ret i in 
          see_ret, i_kai::il_kai) 
        (see_ret, []) i_l in
      see_ret, KIbloc (List.rev il_kai)

  | Iif (ci_l, els_i) ->
      let if_bloc_type env ci =
        let cond, inst = ci in
        let _, c_ty, c_kai = expr_type env cond.e_tree in
        must_be_the_same cond.e_loc Tbool c_ty ;
        let see_ret, i_kai = inst_type env r_ty false inst in
        see_ret, (c_kai, i_kai)
      in
      let if_see_ret, cil_kai = List.fold_right
        (fun ci (if_see_ret, cil_kai) -> 
          let see_ret, ci_kai = if_bloc_type env ci in
          if_see_ret && see_ret, ci_kai::cil_kai)
        ci_l (true, []) in
      let el_see_ret, eli_kai = inst_type env r_ty false els_i in
      see_ret || (if_see_ret && el_see_ret), KIif (cil_kai, eli_kai)

  | Ifor (idn, b, e1, e2, inst) ->
      let env' = { env with tbl = Imap.remove idn.id env.tbl } in begin
      try
        let _, e1_ty, e1_kai = expr_type env' e1.e_tree in
        let _, e2_ty, e2_kai = expr_type env' e2.e_tree in
        must_be_the_same e1.e_loc Tint e1_ty ;
        must_be_the_same e2.e_loc Tint e2_ty ;
        let env'' = update env' idn (TGvariable (false, (Miter, Tint))) 0 in
        let see_ret, ibloc_kai = inst_type env'' r_ty see_ret inst in
        see_ret, KIfor (-env''.frame_size, b, e1_kai, e2_kai, ibloc_kai)
      with Typing_error (loc, err) -> match err with
        | Undeclared_identifier id ->
            if id = idn.id then t_error loc (No_use_bed id)
            else t_error loc (Undeclared_identifier id)
        | _ -> t_error loc err end

  | Iwhile (cond, inst) ->
      let _, c_ty, c_kai = expr_type env cond.e_tree in
      must_be_the_same cond.e_loc Tbool c_ty ;
      let see_ret, ibloc_kai = inst_type env r_ty see_ret inst in
      see_ret, KIwhile (c_kai, ibloc_kai)

(* Dans l'environnement env, si la déclaration decl est bien formé, 
   et renvoie 
   1. le nouveau environnement après cette déclaration 
   2. la liste des fonctions/procédures déclarées (l'ordre arbitraire)
   3. les affectations à faire (l'ordre inversé) *)

let rec decl_type (env, funs, assigns) = function

  | Dtyp ty_idn ->
      update env ty_idn 
      (TGrecord (env.depth, ty_idn.id, (Imap.empty, []))) 1, funs, assigns

  | Dtacc (ty_idn1, ty_idn2) -> begin
      match find_type_id env ty_idn2 with
        | Trecord (dep, r_id,  _) -> 
            update env ty_idn1 (TGaccess (dep, r_id)) 0, funs, assigns
        | _ -> t_error ty_idn2.id_loc Record_required end

  | Dtrec (ty_idn, ch_l) ->
      let tid = ty_idn.id in
      let record_size = ref 0 in
      (* dans le type d'enregistrement on ajoute id : ty *)
      let update_record_step ty (reco_imap, reco_lis) idn =
        let id  = idn.id in
        let loc = idn.id_loc in
        if Imap.mem id reco_imap then t_error loc (Redefine id) ;
        if id = "all" then t_error loc (Reserved_word "all") ;
        let ty_prod = match ty with
          | Trecord (_, _, (_, rp)) -> TPrecord rp
          | _ -> TPvar in
        record_size := !record_size + 8 ;
        Imap.add id (ty, !record_size-8) reco_imap, ty_prod::reco_lis
      in
      (* on ajoute les champs de ch, cas particulier accès de lui-même *)
      let update_record (reco_imap, reco_lis) ch =
        let Ch (idn_l, typ) = ch in
        let ty = find_type_typ env tid typ in
        List.fold_left (update_record_step ty) (reco_imap, reco_lis) idn_l
      in
      let r_imap, r_l = List.fold_left update_record (Imap.empty, []) ch_l in
      (* faire attention à l'ordre dans la liste *)
      let reco = r_imap, List.rev r_l in
      update env ty_idn (TGrecord (env.depth, tid, reco)) (-1), funs, assigns

  (* Dans a1, a2, ..., an : <type> : e, a1 ~ an n'apparaissent pas dans e *)
  | Dvars (idn_l, typ, e_o) ->
      let update_step ty (env, id) idn =
        update env idn (TGvariable (false, (Min_out, ty))) 0, idn.id in
      let ty = find_type_typ env "" typ in 
      let env_res, an_id = List.fold_left (update_step ty) (env, "") idn_l in
      let define_record rp lis idn =
        let id_kai = fst (Imap.find idn.id env_res.tbl) in
        (KIset ((KAvar id_kai, KEnew rp)))::lis
      in
      let def_recs = match ty with
        | Trecord (_, _, (_, rp)) ->
            List.fold_left (define_record rp) assigns idn_l
        | _ -> assigns in
      let assigns = begin try match e_o with
        | Some e ->
            let remove_step env idn =
              { env with tbl = Imap.remove idn.id env.tbl } in
            let env' = List.fold_left remove_step env idn_l in
            let _, e_ty, e_kai = expr_type env' e.e_tree in
            must_be_the_same e.e_loc ty e_ty ;
            let anid_kai = fst (Imap.find an_id env_res.tbl) in
            let ac_kai = match ty with
              | Trecord (_, _, (_, rp)) ->
                  KArecord ((KEacc (KAvar anid_kai)), rp)
              | _ -> KAvar anid_kai in
            (KIset (ac_kai, e_kai))::def_recs
        | _ -> def_recs
      with Typing_error (loc, err) -> match err with
        | Undeclared_identifier id ->
            let id_l = List.map (fun idn -> idn.id) idn_l in
            if List.mem id id_l then t_error loc (No_use_bed id)
            else t_error loc (Undeclared_identifier id)
        | _ -> t_error loc err end in
      env_res, funs, assigns

  | Dbloc d_l ->
      let env', funs', assigns' = 
        List.fold_left decl_type (env, funs, assigns) d_l in
      (* Un type enregistrement déclaré doit être défini avant la fin
         des déclarations de même niveau *)
      if not (Imap.is_empty env'.ndef_types) then begin
        let ndef_id, loc = Imap.choose env'.ndef_types in
        t_error loc (Frozen_bfd ndef_id) end ; 
      env', funs', assigns'

  | Dproc (proc, p_l, decl, inst) ->
      let update_param_step mode ty (env, args) idn =
        let env' = update env idn (TGvariable (true, (mode, ty))) 0 in
        let args' = (idn.id, (mode, ty))::args in
        (env', args')
      in
      let update_param (env, args) param = 
        let Pa (idn_l, mode, typ) = param in
        let ty = find_type_typ env "" typ in
        (* fold_left : l'ordre c'est important ici *)
        let env', args' = 
          List.fold_left (update_param_step mode ty) (env, args) idn_l in
        (env', args')
      in
      (* Un type enregistrement déclaré doit être défini avant l'introduction
         d'un niveau de déclarations supérieur *)
      if not (Imap.is_empty env.ndef_types) then begin
        let ndef_id, loc = Imap.choose env.ndef_types in
        t_error loc (Frozen_bfd ndef_id) end ;
      let env' = { env with depth = env.depth + 1 ; frame_size = 24 } in
      let env', args_ = List.fold_left update_param (env', []) p_l in
      (* rev: l'ordre c'est important ici (sinon il faut fold_right) *)
      let args = List.rev args_ in
      let args_id = List.map (fun (id, nat) -> id) args in
      let proc_num = next_funid () in
      let env'_with_proc = 
        if List.mem proc.id args_id then env'
        else update env' proc (TGprocedure (proc_num, args)) 0 in
      let env'' = {env'_with_proc with frame_size = 0} in
      let env'', funs', assigns' = decl_type (env'', funs, []) decl in
      let see_return, ibloc_kai = inst_type env'' Tnull false inst in
      let proc_body = match ibloc_kai with
        | KIbloc il_kai -> KIbloc ((List.rev assigns') @ il_kai)
        | _ -> assert false in
      let proc_kai = 
        { fid = proc_num ; flevel = env.depth ; ret = see_return ;
          frame_size = env''.frame_size ; body = proc_body } in
      if env'.depth > !max_level then max_level := env'.depth ; 
      update env proc (TGprocedure (proc_num, args)) 0,
      proc_kai::funs', assigns

  | Dfun (f, p_l, r_typ, decl, inst) ->
      let update_param_step mode ty (env, args) idn =
        let env' = update env idn (TGvariable (true, (mode, ty))) 0 in
        let args' = (idn.id, (mode, ty))::args in
        (env', args')
      in
      let update_param (env, args) param =
        let Pa (idn_l, mode, typ) = param in
        let ty = find_type_typ env "" typ in
        let env', args' =
          List.fold_left (update_param_step mode ty) (env, args) idn_l in
        (env', args')
      in
      (* Un type enregistrement déclaré doit être défini avant l'introduction
         d'un niveau de déclarations supérieur *)
      if not (Imap.is_empty env.ndef_types) then begin
        let ndef_id, loc = Imap.choose env.ndef_types in
        t_error loc (Frozen_bfd ndef_id) end ;
      let env' = { env with depth = env.depth + 1 ; frame_size = 24 } in
      let env', args_ = List.fold_left update_param (env', []) p_l in
      let r_ty = find_type_typ env "" r_typ in
      let args = List.rev args_ in
      let args_id = List.map (fun (id, nat) -> id) args in
      let f_num = next_funid () in
      let env'_with_f =
        if List.mem f.id args_id then env'
        else update env' f (TGfunction (f_num, args, r_ty)) 0 in
      let env'' = {env'_with_f with frame_size = 0} in
      let env'', funs',  assigns' = decl_type (env'', funs, []) decl in
      let see_return, ibloc_kai = inst_type env'' r_ty false inst in
      if not see_return then t_error f.id_loc Missing_ret ;
      let f_body = match ibloc_kai with
        | KIbloc il_kai -> KIbloc ((List.rev assigns') @ il_kai)
        | _ -> assert false in
      let f_kai = 
        { fid = f_num ; flevel = env.depth ; ret = see_return ;
          frame_size = env''.frame_size ; body = f_body } in
      if env'.depth > !max_level then max_level := env'.depth ;
      (* Une petite détaille, on vérifie d'abort ce qui ce passe dans
         le corps de la fonction avant de vérifier le nom de la fonction etc *)
      update env f (TGfunction (f_num, args, r_ty)) 0, f_kai::funs', assigns


let check_type file =
  let _, decl, inst = file in
  (* peu importe *)
  let ikai = { level = -1 ; offset = -1 ; by_ref = false } in
  let envtbl = Imap.singleton "put" 
    (ikai, TGprocedure (-1, ["item", (Min, Tchar)])) in
  let envtbl = Imap.add "new_line" (ikai, TGprocedure (-1, [])) envtbl in
  try
    let env = 
      { tbl = envtbl ; record_names = DImap.empty ; 
        ndef_types = Imap.empty ; depth = 1 ; frame_size = 0 } in
    let env', funs, assigns = decl_type (env, [], []) decl in
    let see_return, ibloc_kai = inst_type env' Tnull false inst in
    let body = match ibloc_kai with
      | KIbloc il_kai -> KIbloc ((List.rev assigns) @ il_kai)
      | _ -> assert false in
    { funs = funs ; ibloc = body ; frame_size = env'.frame_size ;
      max_lvl = !max_level ; ret = see_return }
  with Typing_error (loc, err) -> 
    let Loc(pos1, pos2) = loc in
    let l = pos1.pos_lnum in
    let s = pos1.pos_cnum - pos1.pos_bol in
    let f = pos2.pos_cnum - pos1.pos_bol in
    raise (Typing_error_loc (l, s, f, (error_message err)))

