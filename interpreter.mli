open! Core
open! Ast

val subst : Expr.t -> string -> Expr.t -> Expr.t
val reduce : Expr.t -> Expr.t
val eval : Expr.t -> Expr.t Or_error.t
