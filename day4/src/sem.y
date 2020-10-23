%{
#include "stack.h"
#include "ident.h"
Stack s;
Type tmp;
%}
			
%token ADD SUB
%token MUL DIV
%token NUM NL MOD
%token LP RP
%token PROGRAM RBRACE LBRACE
%token IDENT SEMI EQ WRITE
%token INT CHAR COLON
%%

S:		Ls
	;

Ls:		Ls LANG
	|	LANG   
	;	       

LANG:		PROGRAM BLOCK {init(&s);}
	;

BLOCK:		LBRACE DECPART STATEMENTS RBRACE {push(&s, (void *)new_ident(NONE, "NONE"));}
	;

DECPART:	DECPART DECL
	|	DECL
	;

DECL:		INT IDENTS SEMI {tmp = INT_T;}
	|	CHAR IDENTS SEMI {tmp = CHAR_T;}
	;

IDENTS:		IDENT {push(&s, (void *)new_ident(tmp, $1));}
	|	IDENTS COLON IDENT {push(&s, (void*)new_ident(tmp, $3));}
	;

STATEMENTS:	STATEMENTS STATEMENT
        |	STATEMENT {print_stack_info(s);}
	;

STATEMENT:	IDENT EQ E SEMI {}
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

F:		NUM {$$ = $1;}
	|	LP E RP {$$ = $2;}
	|	IDENT {}
	;
%%

#include "lex.yy.c"
int main(int argc, char**argv){
    if (argc > 1){
	yyin = fopen(argv[1],"r");
    }
    yyparse();
}
