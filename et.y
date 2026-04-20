%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    char val[20];
    struct Node *left, *right;
} Node;

Node* newNode(char *v, Node *l, Node *r) {
    Node *n = malloc(sizeof(Node));
    strcpy(n->val, v);
    n->left = l; n->right = r;
    return n;
}

void printTree(Node *n, int level) {
    if (!n) return;
    printTree(n->right, level + 1);
    for (int i = 0; i < level; i++) printf("    ");
    printf("%s\n", n->val);
    printTree(n->left, level + 1);
}
%}

%union { int ival; char *sval; struct Node *node; }
%token <ival> NUM
%token <sval> ID
%token PLUS MINUS MUL DIV LPAREN RPAREN
%type <node> expr

%left PLUS MINUS
%left MUL DIV

%%
start   : expr  { printf("Expression Tree:\n"); printTree($1, 0); }
        ;

expr    : expr PLUS expr    { $$ = newNode("+", $1, $3); }
        | expr MINUS expr   { $$ = newNode("-", $1, $3); }
        | expr MUL expr     { $$ = newNode("*", $1, $3); }
        | expr DIV expr     { $$ = newNode("/", $1, $3); }
        | LPAREN expr RPAREN { $$ = $2; }
        | NUM               { char b[20]; sprintf(b, "%d", $1); $$ = newNode(b, NULL, NULL); }
        | ID                { $$ = newNode($1, NULL, NULL); }
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