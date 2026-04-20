%{
#include <stdio.h>
#include <stdlib.h>
int div_by_zero = 0;
%}

%union { int ival; }
%token <ival> NUM
%token PLUS MINUS MUL DIV LPAREN RPAREN
%type <ival> expr

%left PLUS MINUS
%left MUL DIV

%%
start   : expr  {
            if (div_by_zero)
                printf("Error: Division by zero detected.\n");
            else
                printf("Result: %d\n", $1);
        }
        ;

expr    : expr PLUS expr    { $$ = $1 + $3; }
        | expr MINUS expr   { $$ = $1 - $3; }
        | expr MUL expr     { $$ = $1 * $3; }
        | expr DIV expr     {
            if ($3 == 0) { div_by_zero = 1; $$ = 0; }
            else $$ = $1 / $3;
        }
        | LPAREN expr RPAREN { $$ = $2; }
        | NUM               { $$ = $1; }
        ;
%%

int main() {
    printf("Enter expression: ");
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}