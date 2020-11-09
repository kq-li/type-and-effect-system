{
open Lexing
open Parser

let next_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <-
    { pos with pos_bol = lexbuf.lex_curr_pos; pos_lnum = pos.pos_lnum + 1 }
}

rule read =
  parse
  | [' ' '\t']+
    { read lexbuf }
  | '\r' | '\n' | "\r\n"
    { next_line lexbuf; read lexbuf }
  | '-'? ['0'-'9']+
    { INT (Base.Int.of_string (Lexing.lexeme lexbuf)) }
  | ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '_' '-' '\'']*
    { VAR (Lexing.lexeme lexbuf) }
  | '\\'
    { LAMBDA }
  | '.'
    { DOT }
  | ';'
    { SEMICOLON }
  | '('
    { LPAREN }
  | ')'
    { RPAREN }
  | '+'
    { PLUS }
  | '-'
    { MINUS }
  | '*'
    { MULTIPLY }
  | '/'
    { DIVIDE }
  | _
    { Core.failwithf "syntax error at lexeme: %s" (Lexing.lexeme lexbuf) () }
  | eof
    { EOF }
