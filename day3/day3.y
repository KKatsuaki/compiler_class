%{
    int val[26];
    %}
%token ADD SUB
%token MUL DIV
%token NL MOD NUM
%token LP RP
%token PROGRAM RBRACE LBRACE
%token IDENT SEMI EQ WRITE
%%
S:		Ls
;

Ls:		Ls LANG
|	LANG   
;	       

LANG:		PROGRAM BLOCK 
;
n
BLOCK:		LBRACE STATEMENTS RBRACE
;

STATEMENTS:	STATEMENTS ASTATEMENT
|	ASTATEMENT
;

ASTATEMENT:	IDENT EQ E SEMI {val[$1] = $3;}
    |	WRITE E SEMI {printf("%d\n",$2);}
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
     |	IDENT {$$ = val[$1];}
%%

#include "lex.yy.c"
int main(int argc, char**argv){
    if (argc > 1){
	yyin = fopen(argv[1],"r");
    }
    yyparse();
 }
