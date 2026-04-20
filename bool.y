%{
#include <stdio.h>
%}

%union { int ival; }
%token TRUE FALSE AND OR NOT LPAREN RPAREN
%type <ival> bexpr

%left OR
%left AND
%right NOT

%%
start   : bexpr     { printf("Result: %s\n", $1 ? "true" : "false"); }
        ;

bexpr   : bexpr OR bexpr        { $$ = $1 || $3; }
        | bexpr AND bexpr       { $$ = $1 && $3; }
        | NOT bexpr             { $$ = !$2; }
        | LPAREN bexpr RPAREN   { $$ = $2; }
        | TRUE                  { $$ = 1; }
        | FALSE                 { $$ = 0; }
        ;
%%

int main() {
    printf("Enter boolean expression: ");
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}