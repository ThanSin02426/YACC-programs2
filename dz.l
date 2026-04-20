%{
#include "y.tab.h"
%}

%%
[0-9]+      { yylval.ival = atoi(yytext); return NUM; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MUL; }
"/"         { return DIV; }
"("         { return LPAREN; }
")"         { return RPAREN; }
[ \t\n]     { }
.           { }
%%

int yywrap() { return 1; }