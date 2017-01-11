
(* Arbres de syntaxe abstraite pour la phase production du code *)

open Lexing
open Ast

type offset = int

type ident_kai = { level: int; offset: int; by_ref: bool }

(* Pour une affectation, le comportement pour un record est particulier *)
type ty_prod = TPvar | TPrecord of record_prod
and record_prod = ty_prod list

(* Une fonction c'est une étiquette globale, on associe un numéro 
   à chaque fonction pour la representer.
   Et quand un argument x d'une fonction est de mode in out, on le 
   remplace par KEaddr x qui calcule l'addresse de x. *)

type expr_kai = 
  | KEconst of constant
  | KEacc of access_kai
  | KEaddr of access_kai
  | KEbinop of binop * expr_kai * expr_kai
  | KErecbinop of binop * expr_kai * expr_kai * record_prod
  | KEunop of unop * expr_kai
  | KEnew of record_prod
  | KEcall of int * expr_kai list

and access_kai =
  | KAvar of ident_kai
  | KArecord of expr_kai * record_prod
  | KAacc of expr_kai * int * ty_prod

(* pour for x in ..., on empile directement x *)
type inst_kai =
  | KIset of access_kai * expr_kai
  | KIcall of int * expr_kai list
  | KIput of expr_kai
  | KInewline
  | KIret of expr_kai option
  | KIbloc of inst_kai list
  | KIif of (expr_kai * inst_kai) list * inst_kai
  | KIfor of offset * bool * expr_kai * expr_kai * inst_kai
  | KIwhile of expr_kai * inst_kai

type func = { fid: int ; flevel: int ; 
              ret: bool ; frame_size: int ; body: inst_kai }

(* on indique la taille nécessaire du tableau d'activation du programme 
   principal et le niveau maximal qui peut être atteint *)
type file_kai = { funs: func list ; ibloc: inst_kai ;
                  frame_size: int ; max_lvl: int ; ret: bool }
