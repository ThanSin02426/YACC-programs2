%{
#include "y.tab.h"
%}

%%
[a-zA-Z]+       { return WORD; }
[ \t\n]+        { return SPACE; }
.               { }
%%

int yywrap() { return 1; }