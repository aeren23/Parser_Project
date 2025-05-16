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

%union {
  int ival;
  char* sval;
}

%token <ival> NUMBER BOOL
%token <sval> IDENTIFIER STRING

%%
int main() {
    yyparse(); 
}

void yyerror(const char *s)
{
  fprintf(stderr, "%d. satirda hata: %s\n", yylineno, s);
}
