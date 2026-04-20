%{
#include <stdio.h>
%}

%union { char ch; }
%token <ch> ID
%token PLUS MUL LPAREN RPAREN

%%
E       : T Eprime          { printf("E -> T E'\n"); }
        ;

Eprime  : PLUS T Eprime     { printf("E' -> + T E'\n"); }
        |                   { printf("E' -> epsilon\n"); }
        ;

T       : F Tprime          { printf("T -> F T'\n"); }
        ;

Tprime  : MUL F Tprime      { printf("T' -> * F T'\n"); }
        |                   { printf("T' -> epsilon\n"); }
        ;

F       : LPAREN E RPAREN   { printf("F -> ( E )\n"); }
        | ID                { printf("F -> id\n"); }
        ;
%%

int main() {
    printf("Enter expression: ");
    yyparse();
    printf("Left recursion successfully removed.\n");
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}