%token NUMBER
%token PLUS
%%
S: E
;
E: E PLUS E
| NUMBER
;
%%
#include "lex.yy.c"
main(){
  yyparse();
}
