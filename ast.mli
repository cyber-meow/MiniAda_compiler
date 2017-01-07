
(* Arbres de syntaxe abstraite de Mini-Ada *)

open Lexing

type location = Loc of position * position

type ident = string
type id_node = { id : ident ; id_loc : location }

type unop =
  | Unot | Uneg

type binop =
  | Bplus | Bminus | Bmul | Bdiv | Brem (* opérations arithmétiques *)
  | Beq | Bneq | Blt | Ble | Bgt | Bge (* comparaison *)
  | Band | Bandthen | Bor | Borelse (* pour les booléens *)

type constant = 
  | Cnull
  | Cint of int
  | Cbool of bool
  | Cchar of char

type expr =
  | Econst of constant
  | Eacc of access
  | Ebinop of binop * e_node * e_node
  | Eunop of unop * e_node
  | Enew of id_node
  | Ecall of id_node * e_node list (* appelle un fonction *)
  | Echar'val of e_node

and e_node = { e_tree : expr ; e_loc : location }

(* On peut attribuer valeur à access  *)
and access =
  | Aid of id_node
  | Aacc of e_node * id_node (* <expr> . <ident> *)

type inst =
  | Iset of access * e_node (* <access> := <expr> *)
  | Icall of id_node * e_node list (* appelle un procédure *)
  | Iret of e_node option * location
  | Ibloc of inst list
  | Iif of (e_node * inst) list * inst 
  | Ifor of id_node * bool * e_node * e_node * inst (* bool pour reverse *)
  | Iwhile of e_node * inst

(* Pour la syntaxe <ident>,+ : <type> *)
type typ =
  | Tid of id_node
  | Tac of id_node

type champs = Ch of id_node list * typ

type mode = | Min | Min_out | Miter
type param = Pa of id_node list * mode * typ

type decl = 
  (* type <ident> *)
  | Dtyp of id_node 
  (* type <ident> is access <ident> *)
  | Dtacc of id_node * id_node 
  (* type <ident> is record .. end record *)
  | Dtrec of id_node * champs list 
  (* <ident>,+ : <type> := <expr> *) 
  | Dvars of id_node list * typ * e_node option 
  | Dbloc of decl list
  | Dproc of id_node * param list * decl * inst
  | Dfun of id_node * param list * typ * decl * inst

type file = ident * decl * inst (* Le program en entier *)


