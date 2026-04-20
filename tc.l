%{
#include "y.tab.h"
%}

%%
[0-9]+\.[0-9]+  { yylval.fval = atof(yytext); return FLOAT; }
[0-9]+          { yylval.ival = atoi(yytext); return INT; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MUL; }
"/"             { return DIV; }
[ \t\n]         { }
.               { return yytext[0]; }
%%

int yywrap() { return 1; }