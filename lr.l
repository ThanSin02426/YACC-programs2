%{
#include "y.tab.h"
%}

%%
[a-zA-Z]        { yylval.ch = yytext[0]; return ID; }
"+"             { return PLUS; }
"*"             { return MUL; }
"("             { return LPAREN; }
")"             { return RPAREN; }
[ \t\n]         { }
.               { return yytext[0]; }
%%

int yywrap() { return 1; }