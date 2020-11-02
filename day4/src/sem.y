%{
#include "stack.h"
#include "ident.h"
#include<stdlib.h>
    Stack s;
    Type tp;
    Ident *ident;
    Val *value;
    %}

%union{	      
    int int_val;
    char *text; 			
 }
	      
%token ADD SUB
%token MUL DIV
%token	<int_val> NUM
%token NL MOD
%token LP RP
%token PROGRAM RBRACE LBRACE
%token	<text> IDENT
%token SEMI EQ WRITE
%token INT CHAR COLON
%type	<int_val> E F T
%%

S:		Ls
;

Ls:		Ls LANG
|	LANG   
;	       

LANG:		PROGRAM BLOCK 
;

BLOCK: {push(&s, new_ident(NONE,"SEP"));} LBRACE DECPART STATEMENTS RBRACE 

;

DECPART:	DECPART DECL 
|	DECL 
;

DECL:		INT INT_IDENTS SEMI 
|	CHAR CHAR_IDENTS SEMI 
;



INT_IDENTS:		IDENT {
    if (search($1,s,1) == NULL){
	push(&s, (void *)new_ident(INT_T, $1));
    }else{
	printf("%s is dubplicated...\n",$1);
	exit(-1);
    }
}
|	INT_IDENTS COLON IDENT {
    if (search($3,s,1) == NULL){                
	push(&s, (void *)new_ident(INT_T, $3));
    }else{                                    
	printf("%s is duplicate...\n",$3);
	exit(-1);
    }                                     
}                                         
;

CHAR_IDENTS:             IDENT {            
    if (search($1,s,1) == NULL){                 
        push(&s, (void *)new_ident(CHAR_T, $1));
    }else{                                     
        printf("%s is duplicate...\n",$1);
	exit(-1);
    }                                          
}                                              
|       CHAR_IDENTS COLON IDENT {               
    if (search($3,s,1) == NULL){                 
        push(&s, (void *)new_ident(CHAR_T, $3));
    }else{                                     
        printf("%s is dubplicate...\n",$3);
	exit(-1);
    }                                          
}                                              
;                                              

STATEMENTS:	STATEMENTS STATEMENT
|	STATEMENT {/*print_stack_info(s);*/}
;

STATEMENT:	IDENT EQ E SEMI {
    value = malloc(sizeof(Val));
    ident = search($1,s,0);
    if(ident == NULL){
	printf("%s isn\'t decleard\n", $1);
	exit(-1);
    }else{
	tp = ident->t;
	if(tp==INT_T){
	    value->int_v = $3;
	}else{
	    value->str_v = $3;
	}
	set_val(ident,value);
    }
}
|	WRITE E SEMI {printf("%d\n",$2);}
|	BLOCK 
;

E:		E ADD T {$$ = $1 + $3;}
|	E SUB T {$$ = $1 - $3;}
|	T {$$ = $1;}
;

T:		T MUL F {$$ = $1 * $3;}
|	T DIV F {$$ = $1 / $3;}
|	T MOD F {$$ = $1 % $3;}
|	F {$$ = $1;}
;

F:	NUM {$$ = $1;}
|	LP E RP {$$ = $2;}
|	IDENT {
    ident = search($1,s,0);
    if(ident == NULL){
	printf("%s isn\'t decleard\n", $1);
        exit(-1);                
    }else{
        tp = ident->t;
        if(tp==INT_T){
            $$ = get_val(*ident).int_v;
        }else{                   
            exit(-1);            
        }                        
    }                            
}    
;
%%

#include "lex.yy.c"
int main(int argc, char**argv){
    init(&s);
    push(&s, new_ident(NONE, "FLOR"));
    if (argc > 1){
	yyin = fopen(argv[1],"r");
    }
    yyparse();
}
