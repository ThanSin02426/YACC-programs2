%{
#include <stdio.h>
%}

%token ID NUM COMMA LPAREN RPAREN SEMI

%%
program   : call_list
          ;

call_list : call_list func_call
          | func_call
          ;

func_call : ID LPAREN arg_list RPAREN SEMI
                { printf("Valid function call parsed.\n"); }
          | ID LPAREN RPAREN SEMI
                { printf("Function call with no args parsed.\n"); }
          ;

arg_list  : arg_list COMMA arg
          | arg
          ;

arg       : ID      { printf("Arg: identifier\n"); }
          | NUM     { printf("Arg: number\n"); }
          ;
%%

int main() {
    printf("Enter function call(s):\n");
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}