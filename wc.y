%{
#include <stdio.h>
int total = 0;
%}

%token WORD SPACE

%%
input   : input unit
        | unit
        ;

unit    : WORD  { total++; }
        | SPACE
        ;
%%

int main() {
    yyparse();
    printf("Words: %d\n", total);
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}