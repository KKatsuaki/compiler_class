%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "env.h"
#include "code.h"
    typedef char* str;
    FILE *ofile;
%}

%union{
    int val;
    cptr* code;
    str name;
 }

%token VAR
%token MAIN
%token <name> ID
%token LPAR RPAR
%token COMMA
%token LBRA RBRA
%token WRITE
%token WRITELN
%token SEMI
%token PLUS MINUS
%token MULT DIV
%token <val> NUMBER
%token IF THEN ELSE ENDIF
%token WHILE DO
%token READ
%token COLEQ
%token GE GT LE LT NE EQ
%type <code> stmts st ids body ifstmt cond whilestmt E F T
%%

program : main
;

main : MAIN LBRA vardecls stmts RBRA {
    cptr *tmp;
    tmp = mergecode($4, makecode(O_OPR,0,0));
    printcode(ofile,tmp);
 }
;

vardecls : vardecls vardecl 
| vardecl 
;

vardecl : VAR ids SEMI 
;

ids : ids COMMA ID {addlist($3,0,0);}
| ID {addlist($1,0,0);}
;

stmts : stmts st {$$ = mergecode($1,$2);}
| st {$$ = $1;}
;

st : WRITE E SEMI {
    $$ = mergecode($2,makecode(O_CSP, 0 , 1));
 }
| WRITELN SEMI {
    $$ = makecode(O_CSP, 0, 2);
 }
| READ ID SEMI {
    cptr *tmp;
    list *symbol;

    symbol = search($2);

    if (symbol == NULL){                   
	printf("%s wasn't decleared\n",$2);
	exit(-1);                          
    }                                      

    tmp = makecode(O_CSP,0,0);
    tmp = mergecode(tmp,makecode(O_STO,symbol->l,symbol->a));

    $$ = tmp;
 }
| ID COLEQ E SEMI {
    list *symbol;
    symbol = search($1);
    if (symbol == NULL){
	printf("%s wasn't decleared\n",$1);
	exit(-1);
    }
    $$ = mergecode($3,makecode(O_STO,symbol->l,symbol->a));
 }
| ifstmt {$$=NULL;}
| whilestmt {$$=NULL;}
| body {$$=NULL;}
;

body : LBRA stmts RBRA {$$ = $2;}
;

ifstmt : IF cond THEN st ENDIF SEMI {$$ = NULL;}
| IF cond THEN st ELSE st ENDIF SEMI {$$ = NULL;}
;

whilestmt : WHILE cond DO st {$$ = NULL;}
;

cond : E GT E {$$ = NULL;}
| E GE E {$$ = NULL;}
| E LT E {$$ = NULL;}
| E LE E {$$ = NULL;}
| E NE E {$$ = NULL;}
| E EQ E {$$ = NULL;}
;

E : E PLUS T {
cptr *tmp;                                
 tmp = mergecode($1,$3);                  
 $$ = mergecode(tmp, makecode(O_OPR,0,2));
}
| E MINUS T {
cptr *tmp;                                
 tmp = mergecode($1,$3);                  
 $$ = mergecode(tmp, makecode(O_OPR,0,3));
}
| T {$$ = $1;}
;

T : T MULT F {
cptr *tmp;
 tmp = mergecode($1,$3);
 $$ = mergecode(tmp, makecode(O_OPR,0,4));
}
| T DIV F {
cptr *tmp;                                
 tmp = mergecode($1,$3);                  
 $$ = mergecode(tmp, makecode(O_OPR,0,5));
}
| F {$$=$1;}

F : ID {
    //statement to get the value for the ID
    $$ = NULL;
 }
 | NUMBER {$$=makecode(O_LIT, 0, $1);}
| LPAR E RPAR {$$=$2;}
;

%%

#include "lex.yy.c"

main(int argc, char *argv[]){
    ofile = fopen("code.output", "w");
    if (ofile == NULL){
	perror("ofile");
	exit(EXIT_FAILURE);
    }
    if (argc > 1){
	yyin = fopen(argv[1],"r");
    }

    initialize();

    yyparse();

    if (fclose(ofile) != 0){
	perror("ofile");
	exit(EXIT_FAILURE);
    }
}

