
/* Analyseur syntaxique pour Mini-Ada */

%{
  open Ast
  open Lexing

  let error pos msg =
    let f = pos.pos_fname in
    let l = pos.pos_lnum in
    let c = pos.pos_cnum - pos.pos_bol in
    Format.eprintf "File \"%s\", line %d, characters %d-%d:\n" f l (c-1) c ;
    Format.eprintf "%s@." msg ;
    exit 1

  (* Si on a Procedure/Function name1 = .. Begin .. End name2 *)
  let check_name endp name1 = function
    | None -> ()
    | Some name2 when name2 = name1 -> ()
    | _ -> error endp ("end " ^ name1 ^ "; expected")
%}

%token <Ast.constant> CST
%token <string> IDENT
%token <Ast.binop> CMPG (* =, /= *)
%token <Ast.binop> CMPI (* <, <=, >, >= *)
%token WITH USE BEGIN END
%token EOF
%token PROCEDURE IS FUNCTION IN OUT RETURN 
%token TYPE RECORD ACCESS NEW
%token IF THEN ELSIF ELSE FOR LOOP REVERSE WHILE
%token AND OR NOT
%token PLUS MINUS TIMES DIV REM
%token COMMA COLON SEMICOL DOT DOTDOT APOSTROPHE EQUAL
%token LPAREN, RPAREN

/* Définitions des priorités et associativités des tokens */

%left OR
%left AND
%nonassoc NOT
%nonassoc CMPG
%nonassoc CMPI
%left PLUS MINUS
%left TIMES DIV REM
%nonassoc unary_minus
%left DOT

/* Point d'entrée de la grammaire */
%start file
%type <Ast.file> file

%%

/** Tools **/
%inline snlist(S,x)      : l=separated_nonempty_list(S,x)   {l}
%inline tuple(S,x)       : LPAREN l=snlist(S,x) RPAREN      {l}

file: 
  | WITH ada DOT text_io SEMICOL USE ada DOT text_io SEMICOL
    PROCEDURE name=IDENT IS des=decl*
    BEGIN ins=inst+ END name2=IDENT? SEMICOL EOF
    { check_name $endpos name name2 ;
      name, Dbloc des, Ibloc ins }

ada: 
  | s=IDENT { if s <> "ada" then error $endpos "syntax error" }

text_io: 
  | s=IDENT { if s <> "text_io" then error $endpos "syntax error" }

decl:
  | TYPE id=id_node SEMICOL                                  
      { Dtyp id }
  | TYPE id1=id_node IS ACCESS id2=id_node SEMICOL             
      { Dtacc (id1,id2) }
  | TYPE id=id_node IS RECORD cs=champs+ END RECORD SEMICOL  
      { Dtrec (id,cs) }
  | ids=snlist(COMMA,id_node) COLON ty=typ 
    e=set_expr? SEMICOL                                    
      { Dvars (ids,ty,e) }
  | PROCEDURE name=id_node pas=params 
    IS des=decl* BEGIN ins=inst+ END name2=IDENT? SEMICOL
      { check_name $endpos name.id name2 ;
        Dproc (name, pas, Dbloc des, Ibloc ins) }
  | FUNCTION name=id_node pas=params RETURN ty=typ
    IS des=decl* BEGIN ins=inst+ END name2=IDENT? SEMICOL
      { check_name $endpos name.id name2 ;
        Dfun (name, pas, ty, Dbloc des, Ibloc ins) }

typ:
  | id=id_node           { Tid id }
  | ACCESS id=id_node    { Tac id }

champs:
  | ids=snlist(COMMA,id_node) COLON ty=typ SEMICOL { Ch (ids,ty) }

set_expr:
  | EQUAL e=e_node        { e }

mode:
  | IN      { Min }
  | IN OUT  { Min_out }

param:
  | ids=snlist(COMMA,id_node) COLON m=mode? ty=typ 
    { let m' = match m with
        | None -> Min
        | Some m_ -> m_ in Pa (ids,m',ty) }

params:
  | { [] }
  | pas=tuple(SEMICOL, param) { pas }

inst:
  | a=access EQUAL e=e_node SEMICOL
      { Iset (a, e) }
  | f=id_node SEMICOL
      { Icall (f, []) }
  | f=id_node args=tuple(COMMA, e_node) SEMICOL
      { Icall (f, args) }
  | RETURN e=e_node? SEMICOL
      { Iret (e, Loc ($startpos, $endpos)) }
  | BEGIN ins=inst+ END SEMICOL
      { Ibloc ins }
  | IF cond=e_node THEN is=inst+ efs=elsif_bloc* el=else_bloc END IF SEMICOL
      { Iif ((cond, Ibloc is)::efs, el) }
  | FOR iter=id_node IN r=REVERSE? first=e_node DOTDOT last=e_node
    LOOP ins=inst+ END LOOP SEMICOL
      { let rev = match r with
          | None -> false
          | _ -> true in
        Ifor (iter, rev, first, last, Ibloc ins) }
  | WHILE cond=e_node LOOP ins=inst+ END LOOP SEMICOL
      { Iwhile (cond, Ibloc ins) }

access:
  | id=id_node                  { Aid id }
  | e=e_node DOT id=id_node     { Aacc (e, id) }

elsif_bloc:
  | ELSIF cond=e_node THEN ins=inst+  { cond, Ibloc ins }

else_bloc:
  | { Ibloc [] }
  | ELSE ins=inst+  { Ibloc ins }

expr:
  | c=CST
      { Econst c }
  | LPAREN e=expr RPAREN
      { e }
  | a=access
      { Eacc a }
  | e1=e_node o=binop e2=e_node
      { Ebinop (o, e1, e2) }
  | e1=e_node AND THEN e2=e_node %prec AND
      { Ebinop (Bandthen, e1, e2) }
  | e1=e_node OR ELSE e2=e_node %prec OR
      { Ebinop (Borelse, e1, e2) }
  | NOT e=e_node
      { Eunop (Unot, e) }
  | MINUS e=e_node %prec unary_minus
      { Eunop (Uneg, e) }
  | NEW id=id_node
      { Enew id }
  | f=id_node args=tuple(COMMA, e_node)
      { Ecall (f, args) }
  | ch=IDENT APOSTROPHE va=IDENT LPAREN e=e_node RPAREN
      { if (ch, va) <> ("character", "val") then error $endpos "syntax error" ;
        Echar'val e }

e_node:
  | e=expr { { e_tree = e ; e_loc = Loc($startpos, $endpos) } }

id_node:
  | id=IDENT { { id = id ; id_loc = Loc($startpos, $endpos) } }

%inline binop:
  | PLUS                { Bplus }
  | MINUS               { Bminus }
  | TIMES               { Bmul }
  | DIV                 { Bdiv }
  | REM                 { Brem }
  | cg=CMPG             { cg }
  | ci=CMPI             { ci }
  | AND                 { Band }
  | OR                  { Bor }


