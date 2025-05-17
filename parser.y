%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>


//Fonksiyon prototipleri
typedef struct {
    char* name;
    char* params[10];
    int paramCount;
    char* body;
} Function;

Function funcs[50];
int funcCount = 0;

char* paramDefs[10];
int paramDefCount = 0;

int args[10];
int argCount = 0;
//Fonksiyon prototipleri sonu

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


// Flex buffer fonksiyon prototipleri:
typedef void* YY_BUFFER_STATE;
extern YY_BUFFER_STATE yy_scan_string(const char *str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);
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

%token <sval> BODY



%type <ival> expression condition
%type program command function_definition print_statement assignment



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
    | expression EXPONENT expression { $$ = pow($1, $3); }
    | expression MOD expression { $$ = $1 % $3; }
    | expression ROOT expression { $$ = sqrt($3); }

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


input_statement:
    INPUT IDENTIFIER {
        int val;
        printf(">> ");
        scanf("%d", &val);
        setVariable($2, val);
    }
;

function_definition:
    FUNCTION IDENTIFIER LPAREN param_def_list RPAREN BODY ENDFUNCTION
    {
        funcs[funcCount].name       = strdup($2);
        funcs[funcCount].paramCount = paramDefCount;
        for (int i = 0; i < paramDefCount; i++)
            funcs[funcCount].params[i] = strdup(paramDefs[i]);
        funcs[funcCount].body       = strdup($6);
        funcCount++;
        paramDefCount = 0;
    }
;



function_call:
    IDENTIFIER LPAREN param_list RPAREN {
        int found = 0;
        for (int i = 0; i < funcCount; i++) {
            if (strcmp(funcs[i].name, $1) == 0) {
                found = 1;
                // Parametreleri doğru atamak için:
                for (int j = 0; j < funcs[i].paramCount; j++) {
                    setVariable(funcs[i].params[j], args[j]);
                }
                // Fonksiyon gövdesini string olarak parse et
                {
                    YY_BUFFER_STATE buf = yy_scan_string(funcs[i].body);
                    yyparse();
                    yy_delete_buffer(buf);
                }
                break;
            }
        }
        if (!found) {
            printf("Fonksiyon bulunamadı: %s\n", $1);
        }
        argCount = 0;
    }
;


param_def_list:
      IDENTIFIER  {
          paramDefs[0] = strdup($1);
          paramDefCount = 1;
      }
    | param_def_list COMMA IDENTIFIER {
          paramDefs[paramDefCount] = strdup($3);
          paramDefCount++;
      }
;

param_list:
      expression  {
          args[0] = $1;
          argCount = 1;
      }
    | param_list COMMA expression {
          args[argCount] = $3;
          argCount++;
      }
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
