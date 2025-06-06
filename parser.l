
%{
#include "parser.tab.h"
#include <string.h>
%}
%option noyywrap 
%option yylineno 


%%

"--".*            {/* yorum satırları */}
[ \t]             {/* boşlukları geç */}
\n                { /*Şimdilik geç*/}
"if"            { return IF; }
"then"             { return THEN; }
"else"            { return ELSE; }
"loop"           { return LOOP; }

"{"([^}]|\n)*"}"  {
    /* yytext = "{ … }" */
    yylval.sval = strndup(yytext+1, yyleng-2);
    return BODY;
}


"+"    {return SUM;}
"-"    {return SUBSTRACTION;}
"*"    {return MULTIPLICATION;}
"/"    {return DIVIDE;}
"//"    {return ROOT;}
"%"    {return MOD;}
"**"    {return EXPONENT;}
"<"    {return LESS;}
">"    {return MORE;}
"<="    {return LESS_EQUAL;}
">="    {return MORE_EQUAL;}
"="    {return EQUALS;}
"=/="    {return DIFFERENT;}
"~"      {return NOT;}   
"=:"              { return ASSIGN; }

","     { return COMMA; }

"print"   { return PRINT; }
"input"   { return INPUT; }

"true"     { yylval.ival = 1; return BOOL; }
"false"    { yylval.ival = 0; return BOOL; }

"and"   { return AND; }
"or"    { return OR; }

"abs"   { return ABS; }
"log"   { return LOG; }

"sin"   { return SIN; }
"cos"   {return COS;}
"tan"   {return TAN;}
"cot"   {return COT;}

\"[^\"]*\"   { yylval.sval = strdup(yytext); return STRING; /**/}


"function"   { return FUNCTION; }
"endfunc"    { return ENDFUNCTION; }



"return"     { return RETURN; }



"("    { return LPAREN; }
")"    { return RPAREN; }



"draw_circle"  { return DRAW_CIRCLE; }
"draw_line"  { return DRAW_LINE; }
"draw_rectangle" { return DRAW_RECT; }
"draw_triangle"  { return DRAW_TRIANGLE; }

"key_pressed"   { return KEY_PRESSED; }
"key_UP"    { yylval.ival = 1; return NUMBER; }
"key_DOWN"     { yylval.ival = 2; return NUMBER; }
"key_R"       { yylval.ival = 3; return NUMBER; }
"key_L"       { yylval.ival = 4; return NUMBER; }



[0-9]+            { yylval.ival = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.sval = strdup(yytext); return IDENTIFIER; }
.                 { return *yytext; } //Tanımlanmamış her karakter varsa onu ASCII değeriyle döner.

%%
