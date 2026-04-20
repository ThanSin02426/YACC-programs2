%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%union {
    int ival;
    char *sval;
}

%token <ival> NUM
%token <sval> ID
%token PLUS MINUS MUL DIV LPAREN RPAREN

%left PLUS MINUS
%left MUL DIV

%%
start   : expr '\n'     { printf("\n"); }
        ;

expr    : expr PLUS expr    { printf("+ "); }
        | expr MINUS expr   { printf("- "); }
        | expr MUL expr     { printf("* "); }
        | expr DIV expr     { printf("/ "); }
        | LPAREN expr RPAREN
        | NUM               { printf("%d ", $1); }
        | ID                { printf("%s ", $1); }
        ;
%%

int main() {
    printf("Enter infix expression: ");
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}