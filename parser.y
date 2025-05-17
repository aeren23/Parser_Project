%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
extern int yylineno;

/* Değişken tablosu */
typedef struct {
    char* name;
    int value;
} Variable;

Variable vars[100];
int varCount = 0;

/* Değişken set etme fonksiyonu */
void setVariable(char* name, int value) {
    for (int i = 0; i < varCount; i++) {
        if (strcmp(vars[i].name, name) == 0) {
            vars[i].value = value;
            return;
        }
    }
    vars[varCount].name = strdup(name);
    vars[varCount].value = value;
    varCount++;
}

/* Değişken okuma fonksiyonu */
int getVariable(char* name) {
    for (int i = 0; i < varCount; i++) {
        if (strcmp(vars[i].name, name) == 0) {
            return vars[i].value;
        }
    }
    printf("HATA: '%s' değişkeni tanımlı değil!\n", name);
    exit(1);
}
%}

%union {
  int ival;
  char* sval;
}

%token IF THEN ELSE LOOP START END
%token SUM SUBSTRACTION MULTIPLICATION DIVIDE ROOT MOD EXPONENT
%token LESS MORE LESS_EQUAL MORE_EQUAL EQUALS DIFFERENT NOT
%token ASSIGN
%token COMMA PRINT INPUT
%token AND OR
%token ABS LOG SIN COS TAN COT
%token FUNCTION ENDFUNCTION RETURN
%token LPAREN RPAREN NEWLINE

%token <ival> NUMBER BOOL
%token <sval> IDENTIFIER STRING

%type <ival> expression condition

%%

program:
      program command
    | command
;

command:
      assignment
    | if_statement
    | loop_statement
    | print_statement
    | function_definition
    | function_call
;

assignment:
    IDENTIFIER ASSIGN expression {
        setVariable($1, $3);
    }
;

expression:
      expression SUM expression           { $$ = $1 + $3; }
    | expression SUBSTRACTION expression  { $$ = $1 - $3; }
    | expression MULTIPLICATION expression { $$ = $1 * $3; }
    | expression DIVIDE expression        { $$ = $1 / $3; }
    | NUMBER                              { $$ = $1; }
    | BOOL                                { $$ = $1; }
    | IDENTIFIER                          { $$ = getVariable($1); }
    | LPAREN expression RPAREN            { $$ = $2; }

;

if_statement:
    IF condition THEN START program END
  | IF condition THEN START program END ELSE START program END
;

condition:
      expression LESS expression          { $$ = $1 < $3; }
    | expression MORE expression          { $$ = $1 > $3; }
    | expression LESS_EQUAL expression    { $$ = $1 <= $3; }
    | expression MORE_EQUAL expression    { $$ = $1 >= $3; }
    | expression EQUALS expression        { $$ = $1 == $3; }
    | expression DIFFERENT expression     { $$ = $1 != $3; }
;

loop_statement:
    LOOP condition START program END
;

print_statement:
    PRINT expression {
        printf("%d\n", $2);
    }
  | PRINT STRING {
        printf("%s\n", $2);
    }
;

function_definition:
    FUNCTION IDENTIFIER param_def_list START program END ENDFUNCTION
    { /* Şu an semantic yorumlama yok, syntax kontrolü geçiyor */ }
;

function_call:
    IDENTIFIER LPAREN param_list RPAREN
    { /* Şu an semantic yorumlama yok */ }
;

param_def_list:
      IDENTIFIER
    | param_def_list COMMA IDENTIFIER
;

param_list:
      expression
    | param_list COMMA expression
;



%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s)
{
  fprintf(stderr, "%d. satirda hata: %s\n", yylineno, s);
}
