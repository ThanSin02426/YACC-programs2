%{
#include "y.tab.h"
%}

%%
[0-9]+          { yylval.ival = atoi(yytext); return NUM; }
[a-zA-Z]+       { yylval.sval = strdup(yytext); return ID; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MUL; }
"/"             { return DIV; }
"("             { return LPAREN; }
")"             { return RPAREN; }
[ \t\n]         { }
.               { return yytext[0]; }
%%

int yywrap() { return 1; }