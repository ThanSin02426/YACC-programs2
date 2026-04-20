%{
#include "y.tab.h"
%}

%%
"if"            { return IF; }
"else"          { return ELSE; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
[0-9]+          { return NUM; }
"<"|">"|"=="    { return RELOP; }
[ \t\n]         { }
.               { }
%%

int yywrap() { return 1; }