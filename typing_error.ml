
(* Les erreurs de compilations qui peuvent arriver quand on fait le typage *)

open Ast
open Ast_kai

module Imap = Map.Make(String)
type depth = int


(* Le typage d'un variable *)

type ty = 
  | Tint | Tchar | Tbool | Tnull
  | Trecord of depth * ident * record | Taccess of depth * ident

and record = ((ty * offset) Imap.t) * record_prod

(* Gérer les erreurs *)

type error_kind =
  | Type_error of ty * ty
  | Undeclared_identifier of ident 
  | Reserved_word of ident
  | Not_value of ident
  | Not_applied of ident
  | Number_arguments of ident * int * int
  | Procedure_no_value of ident
  | Function_not_procedure of ident
  | No_field_name of ident * ident
  | Prefix_selection of ty 
  | Prefix_selection_new
  | Prefix_dereference of ty 
  | Record_required 
  | Type_required
  | Left_hand_side
  | Actual_variable of ident
  | Vfor_nomodified
  | Redefine of ident
  | Refer_itself
  | No_use_bed of ident
  | Invalid_bfd of ident
  | Frozen_bfd of ident
  | Procedure_no_retv
  | Missing_ret_expr
  | Missing_ret

exception Typing_error of location * error_kind
exception Typing_error_loc of int * int * int * string

let t_error loc k = raise (Typing_error (loc, k))

let show id = "'" ^ id ^ "'"

let name_of_type = function
  | Tint -> "type int"
  | Tbool -> "type bool"
  | Tchar -> "type char"
  | Tnull -> "type null"
  | Trecord (d, r_id, _) -> 
      "record type " ^ (show r_id) ^ " (depth " ^ (string_of_int d) ^ ")"
  | Taccess (d, r_id) -> 
      "type access " ^ (show r_id) ^ " (depth " ^ (string_of_int d) ^ ")"

let error_message = function
  | Type_error (ty1, ty2) -> 
      "this expression has " ^ (name_of_type ty1) ^ 
      " but is expected to have " ^ (name_of_type ty2)
  | Undeclared_identifier id ->
      "use of undeclared identifier " ^ (show id)
  | Reserved_word id ->
      "reserved word " ^ (show id) ^ " cannot be used as identifier"
  | Not_value id ->
      (show id) ^ " doesn't refer to a value"
  | Not_applied id ->
      (show id) ^ " is not a function/procedure, it cannot be applied"
  | Number_arguments (f, required, provided) ->
      (show f) ^ " requires " ^ (string_of_int required) ^ " arguments, but " 
      ^ (string_of_int provided) ^ " arguments were provided"
  | Procedure_no_value proc ->
      (show proc) ^ " is a procedure, a procedure doesn't have a return value"
  | Function_not_procedure f ->
      "cannot use function " ^ (show f) ^ " in a procedure call"
  | No_field_name (field, record) ->
      "no field named " ^ (show field) ^ " in " ^ (show record)
  | Prefix_selection ty ->
      "prefix for selection must be of access or record type, but this 
       expression has " ^ (name_of_type ty)
  | Prefix_selection_new ->
      "prefix for selection cannot be a 'new' record"
  | Prefix_dereference ty ->
      "prefix of a deference must be an access type, but this 
       expression has " ^ (name_of_type ty)
  | Record_required ->
      "record name required in this context"
  | Type_required ->
      "type name required in this context"
  | Left_hand_side ->
      "left hand side of assignment must be a variable"
  | Actual_variable id ->
      "actual for " ^ (show id) ^ " must be a variable"
  | Vfor_nomodified ->
      "variable of for loop cannot be modified"
  | Redefine id ->
      "redefinition of " ^ (show id)
  | Refer_itself ->
      "type declaration cannot refer to itself"
  | No_use_bed id ->
      "object " ^ (show id) ^ " cannot be used before end of its declaration"
  | Invalid_bfd ty_id ->
      "invalid use of type " ^ (show ty_id) ^ " before its full declaration"
  | Frozen_bfd ty_id ->
      "type " ^ (show ty_id) ^ " is frozen before its full declaration"
  | Procedure_no_retv ->
      "procedure cannot return value (use function)"
  | Missing_ret_expr ->
      "missing expression in return from function"
  | Missing_ret ->
      "missing \"Return\" statement in function body"
