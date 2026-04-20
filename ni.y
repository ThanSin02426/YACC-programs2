%{
#include <stdio.h>
int depth = 0;
%}

%token IF ELSE LPAREN RPAREN LBRACE RBRACE ID NUM RELOP
%right ELSE

%%
program : stmt_list         { printf("Nested if parsed successfully.\n"); }
        ;

stmt_list : stmt_list stmt
          | stmt
          ;

stmt    : if_stmt
        | ID
        | NUM
        ;

if_stmt : IF LPAREN condition RPAREN block
            { depth++; printf("if-block at depth %d\n", depth); depth--; }
        | IF LPAREN condition RPAREN block ELSE block
            { depth++; printf("if-else block at depth %d\n", depth); depth--; }
        | IF LPAREN condition RPAREN block ELSE if_stmt
            { printf("else-if chain parsed\n"); }
        ;

block   : LBRACE stmt_list RBRACE
        | stmt
        ;

condition : ID RELOP ID
          | ID RELOP NUM
          | NUM RELOP NUM
          ;
%%

int main() {
    printf("Enter nested if statement:\n");
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}