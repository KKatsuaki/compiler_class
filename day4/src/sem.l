%{
#include<stdlib.h>
#include<string.h>
char *tmp;
%}
%%
"//".*|"/*"([^*]|\*+[^*/])*\*+"/" {/*comment*/}
"program" return PROGRAM;
"=" return EQ;
";" return SEMI;
"write" return WRITE;
"int" return INT;
"char" return CHAR;
"," return COLON;
"+" return ADD;
"-" return SUB;
"*" return MUL;
"%" return MOD;
"/" return DIV;
"{" return LBRACE;
"}" return RBRACE;
"(" return LP;
")" return RP;
[a-zA-Z][a-zA-Z0-9]* {
tmp = calloc(strlen(yytext)+1,sizeof(char));
if(tmp==NULL){exit(-1);}
strcpy(tmp,yytext);
yylval.text = tmp;
return IDENT;
}
[0-9]+ {yylval.int_val = atoi(yytext); return NUM;}
[\t\s\n]+ {}
. {}


