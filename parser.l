%{
#include "parser.tab.h"
%}
%option noyywrap 
%option yylineno 


%%

"--".*            {/* yorum satırları */}
[ \t]             {/* boşlukları geç */}
\n                { return NEWLINE; }
"if"            { return IF; }
"then"             { return THEN; }
"else"            { return ELSE; }
"loop"           { return LOOP; }
"["            { return START; }
"]"            { return END; }
"+"    {return SUM;}
"-"    {return SUBSTRACTION;}
"*"    {return MULTIPLICATION;}
"/"    {return DIVIDE;}
"%"    {return MOD;}
"^"    {return EXPONENT;}
"<"    {return LESS;}
">"    {return MORE;}
"<="    {return LESS_EQUAL;}
">="    {return MORE_EQUAL;}
"="    {return EQUALS;}
"=/="    {return DIFFERENT;}
"~"      {return NOT;}   
"=:"              { return ASSIGN; }
[0-9]+            { yylval.ival = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.sval = strdup(yytext); return IDENTIFIER; }
.                 { return *yytext; } //Tanımlanmamış her karakter varsa onu ASCII değeriyle döner.

%%