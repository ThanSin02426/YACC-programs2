%{
#include <stdio.h>
%}

%union { int ival; }
%token <ival> NUM
%token SWITCH CASE BREAK DEFAULT ID COLON LBRACE RBRACE LPAREN RPAREN

%%
switch_stmt : SWITCH LPAREN ID RPAREN LBRACE case_list RBRACE
                { printf("Valid switch statement parsed.\n"); }
            ;

case_list   : case_list case_item
            | case_item
            ;

case_item   : CASE NUM COLON stmt_list BREAK
                { printf("Case %d parsed.\n", $2); }
            | DEFAULT COLON stmt_list
                { printf("Default case parsed.\n"); }
            ;

stmt_list   : stmt_list ID
            | ID
            |
            ;
%%

int main() {
    printf("Enter switch statement:\n");
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}