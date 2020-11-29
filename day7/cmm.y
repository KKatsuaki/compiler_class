%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "env.h"
#include "code.h"
    typedef char* str;
    FILE *ofile;
    int offset = SYSTEM_AREA;
cptr *calc(cptr *e1, cptr *e2, int opr);
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
    tmp = mergecode(makecode(O_INT,0,offset),$4);    
    tmp = mergecode(tmp, makecode(O_OPR,0,0));
    printcode(ofile,tmp);
 }
;

vardecls : vardecls vardecl 
| vardecl 
;

vardecl : VAR ids SEMI 
;

ids : ids COMMA ID {
    if(search($3)){
	printf("%s is duplicated...", $3);
	exit(-1);
    }
    addlist($3,offset++,0);}
| ID {
    if(search($1)){                       
        printf("%s is duplicated...", $1);
        exit(-1);                        
    }
    addlist($1,offset++,0);
 }
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
| ifstmt {$$=$1;}
| whilestmt {$$=$1;}
| body {$$=$1;}
;

body : LBRA stmts RBRA {$$ = $2;}
;

ifstmt : IF cond THEN st ENDIF SEMI {
    cptr *tmp;
    int lab1 = makelabel();
    tmp = $2;
    tmp = mergecode(tmp, makecode(O_JPC, 0, lab1));
    tmp = mergecode(tmp, $4);
    tmp = mergecode(tmp, makecode(O_LAB, 0, lab1));
    $$ = tmp;
}
| IF cond THEN st ELSE st ENDIF SEMI {
    cptr *tmp;                                     
    int lab1 = makelabel();
    int lab2 = makelabel();                        
    tmp = $2;                                      
    tmp = mergecode(tmp, makecode(O_JPC, 0, lab1));
    tmp = mergecode(tmp, $4);                      
    tmp = mergecode(tmp, makecode(O_JMP, 0, lab2));
    tmp = mergecode(tmp, makecode(O_LAB, 0, lab1));
    tmp = mergecode(tmp, $6);    
    tmp = mergecode(tmp, makecode(O_LAB, 0, lab2));
    $$ = tmp;                                      
}
;

whilestmt : WHILE cond DO st {
    cptr *tmp;
    int lab1 = makelabel();
    int lab2 = makelabel();

    tmp = makecode(O_LAB,0,lab1);
    tmp = mergecode(tmp,$2);
    tmp = mergecode(tmp,makecode(O_JPC,0,lab2));
    tmp = mergecode(tmp, $4);
    tmp = mergecode(tmp, makecode(O_JMP, 0, lab1));
    tmp = mergecode(tmp, makecode(O_LAB, 0, lab2));
    $$ = tmp;
}
;

cond : E GT E {$$ = calc($1,$3,12);}
| E GE E {$$ = calc($1,$3,11);}
| E LT E {$$ = calc($1,$3,10);}
| E LE E {$$ = calc($1,$3,13);}
| E NE E {$$ = calc($1,$3,8);}
| E EQ E {$$ = calc($1,$3,9);}
;

E : E PLUS T {$$ = calc($1,$3,2);}
| E MINUS T {$$ = calc($1,$3,3);}
| T {$$ = $1;}
;

T : T MULT F {$$ = calc($1,$3,4);}
| T DIV F {$$ = calc($1,$3,5);}
| F {$$=$1;}

F : ID {
    list *tmp;
    tmp = search($1);
    if (tmp){
	$$ = makecode(O_LOD,tmp->l,tmp->a);
    }else{
	printf("%s isn't dcleared...",$1);
    }
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

cptr *calc(cptr *e1, cptr *e2, int opr){
    cptr *tmp;
    tmp = mergecode(e1,e2);
    tmp = mergecode(tmp, makecode(O_OPR, 0, opr));
    return tmp;
}
