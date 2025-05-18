
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

%token IF THEN ELSE LOOP 
%token SUM SUBSTRACTION MULTIPLICATION DIVIDE ROOT MOD EXPONENT
%token LESS MORE LESS_EQUAL MORE_EQUAL EQUALS DIFFERENT NOT
%token ASSIGN
%token COMMA PRINT INPUT
%token AND OR
%token ABS LOG SIN COS TAN COT
%token FUNCTION ENDFUNCTION RETURN
%token LPAREN RPAREN NEWLINE


%token KEY_PRESSED
%token <ival> KEY_CODE


%token <ival> NUMBER BOOL
%token <sval> IDENTIFIER STRING

%token <sval> BODY

%token <sval> BLOCK

%token DRAW_CIRCLE DRAW_LINE DRAW_RECT DRAW_TRIANGLE


%type <ival> expression condition
%type program command function_definition print_statement assignment

%type <ival> relation_op

%start program

%%


key_check:
    KEY_PRESSED NUMBER {
        printf("Tuş basildi: %d\n", $2);
    }
;



drawing_command:
      DRAW_CIRCLE expression expression expression {
          printf("Daire çizildi: (%d,%d) yariçap: %d\n", $2, $3, $4);
      }
    | DRAW_LINE expression expression expression expression {
          printf("Çizgi: (%d,%d) → (%d,%d)\n", $2, $3, $4, $5);
      }
    | DRAW_RECT expression expression {
          printf("Dikdörtgen: En:(%d), Boy:(%d)\n", $2, $3);
      }
    | DRAW_TRIANGLE expression expression {
          printf("Üçgen: Yükseklik:(%d), Taban:(%d)\n", $2, $3);
      }
;


program:
    program command
  | command
;

command:
      assignment
    | if_statement
    | loop_statement
    | print_statement
    | input_statement
    | function_definition
    | function_call
    | drawing_command
    | key_check
;

assignment:
    IDENTIFIER ASSIGN expression {
        setVariable($1, $3);
    }
;

expression:
      expression SUM expression             { $$ = $1 + $3; }
    | expression SUBSTRACTION expression    { $$ = $1 - $3; }
    | expression MULTIPLICATION expression  { $$ = $1 * $3; }
    | expression DIVIDE expression          { $$ = $1 / $3; }
    | expression MOD expression             { $$ = $1 % $3; }
    | expression EXPONENT expression        { $$ = pow($1, $3); }
    | expression ROOT expression            { $$ = pow($3, 1.0 / $1); }
    | SIN expression                        { $$ = sin($2); }
    | COS expression                        { $$ = cos($2); }
    | TAN expression                        { $$ = tan($2); }
    | COT expression                        { $$ = 1.0 / tan($2); }
    | NUMBER                                { $$ = $1; }
    | BOOL                                  { $$ = $1; }
    | IDENTIFIER                            { $$ = getVariable($1); }
    | LPAREN expression RPAREN              { $$ = $2; }
    | ABS expression { $$ = abs($2); }
;


if_statement:
    IF condition THEN BODY
    {
      if ($2) {
        YY_BUFFER_STATE b = yy_scan_string($4);
        yyparse();
        yy_delete_buffer(b);
        return 0;
      }
    }
  | IF condition THEN BODY ELSE BODY
    {
      if ($2) {
        YY_BUFFER_STATE b1 = yy_scan_string($4);
        yyparse();
        yy_delete_buffer(b1);
        return 0;
      } else {
        YY_BUFFER_STATE b2 = yy_scan_string($6);
        yyparse();
        yy_delete_buffer(b2);
        return 0; 
      }
    }
;


condition:
      expression LESS expression          { $$ = $1 < $3; }
    | expression MORE expression          { $$ = $1 > $3; }
    | expression LESS_EQUAL expression    { $$ = $1 <= $3; }
    | expression MORE_EQUAL expression    { $$ = $1 >= $3; }
    | expression EQUALS expression        { $$ = $1 == $3; }
    | expression DIFFERENT expression     { $$ = $1 != $3; }
    | condition AND condition             { $$ = $1 && $3; }
    | condition OR condition              { $$ = $1 || $3; }
    | NOT condition                       { $$ = !$2; }
    | KEY_PRESSED NUMBER                  { 
        printf("Tuş kodunu gir (ör: 38): "); 
        int c; 
        scanf("%d", &c); 
        $$ = (c == $2); 
    }
;

relation_op:
      LESS        { $$ = 1; }
    | MORE        { $$ = 2; }
    | LESS_EQUAL  { $$ = 3; }
    | MORE_EQUAL  { $$ = 4; }
    | EQUALS      { $$ = 5; }
    | DIFFERENT   { $$ = 6; }
;

loop_statement:
    LOOP LPAREN IDENTIFIER relation_op NUMBER RPAREN BODY
    {
        int _var, _cond_val;
        do {
            _var = getVariable($3);
            _cond_val = 0;
            // Koşulu kontrol et
            switch ($4) {
                case 1: _cond_val = (_var < $5); break;
                case 2: _cond_val = (_var > $5); break;
                case 3: _cond_val = (_var <= $5); break;
                case 4: _cond_val = (_var >= $5); break;
                case 5: _cond_val = (_var == $5); break;
                case 6: _cond_val = (_var != $5); break;
            }
            if (!_cond_val) return 0;

            YY_BUFFER_STATE b = yy_scan_string($7);
            yyparse();
            yy_delete_buffer(b);
        } while (1);
    }
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
    INPUT IDENTIFIER NUMBER {
        setVariable($2, $3);
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
                    return 0;
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
    if (yyparse() == 0) {
        printf("[Başarili] Kod gramer kurallarina uygundur.\n");
    }
    return 0;
}

void yyerror(const char *s)
{
  fprintf(stderr, "%d. satirda hata: %s\n", yylineno, s);
}
