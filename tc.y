%{
#include <stdio.h>
#define TYPE_INT   0
#define TYPE_FLOAT 1
%}

%union {
    int ival;
    float fval;
    int type;
}

%token <ival> INT
%token <fval> FLOAT
%token PLUS MINUS MUL DIV
%type <type> expr

%%
stmt    : expr  {
            if ($1 == TYPE_INT)
                printf("Result type: int\n");
            else
                printf("Result type: float\n");
        }
        ;

expr    : expr PLUS expr    { $$ = ($1 == TYPE_FLOAT || $3 == TYPE_FLOAT) ? TYPE_FLOAT : TYPE_INT; }
        | expr MINUS expr   { $$ = ($1 == TYPE_FLOAT || $3 == TYPE_FLOAT) ? TYPE_FLOAT : TYPE_INT; }
        | expr MUL expr     { $$ = ($1 == TYPE_FLOAT || $3 == TYPE_FLOAT) ? TYPE_FLOAT : TYPE_INT; }
        | expr DIV expr     { $$ = TYPE_FLOAT; }
        | INT               { $$ = TYPE_INT; printf("int(%d) ", $1); }
        | FLOAT             { $$ = TYPE_FLOAT; printf("float(%.2f) ", $1); }
        ;
%%

int main() {
    printf("Enter expression: ");
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Type error: %s\n", s);
}