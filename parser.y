%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex(void);
extern int yylineno;
%}

%token IF THEN ELSE LOOP START END
%token SUM SUBSTRACTION MULTIPLICATION DIVIDE ROOT MOD EXPONENT
%token LESS MORE LESS_EQUAL MORE_EQUAL EQUALS DIFFERENT NOT
%token ASSIGN
%token COMMA PRINT INPUT
%token BOOL
%token AND OR
%token ABS LOG SIN COS TAN COT
%token FUNCTION ENDFUNCTION RETURN
%token STRING NUMBER IDENTIFIER
%token NEWLINE
%token LPAREN RPAREN


%union {
  int ival;
  char* sval;
}

%token <ival> NUMBER BOOL
%token <sval> IDENTIFIER STRING


%%
program:
      program command
    | command
;

command:
      assignment NEWLINE
    | if_statement
    | loop_statement
    | print_statement NEWLINE
    | input_statement NEWLINE
    | function_definition
    | function_call NEWLINE
;

assignment:
    IDENTIFIER ASSIGN expression
;


expression:
      expression SUM expression
    | expression SUBSTRACTION expression
    | expression MULTIPLICATION expression
    | expression DIVIDE expression
    | expression MOD expression
    | expression EXPONENT expression
    | expression ROOT expression
    | ABS expression
    | LOG expression
    | SIN expression
    | COS expression
    | TAN expression
    | COT expression
    | BOOL
    | NUMBER
    | STRING
    | IDENTIFIER
    | LPAREN expression RPAREN
;


if_statement:
    IF condition THEN START program END
  | IF condition THEN START program END ELSE START program END
;

condition:
      expression LESS expression
    | expression MORE expression
    | expression LESS_EQUAL expression
    | expression MORE_EQUAL expression
    | expression EQUALS expression
    | expression DIFFERENT expression
    | NOT expression
    | expression AND expression
    | expression OR expression
    | LPAREN condition RPAREN
    | condition AND condition
    | condition OR condition
    |condition EQUALS condition
    | condition DIFFERENT condition
;


%%
int main() {
    yyparse(); 
}

void yyerror(const char *s)
{
  fprintf(stderr, "%d. satirda hata: %s\n", yylineno, s);
}
