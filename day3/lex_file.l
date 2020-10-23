%%
"//".*|"/*"([^*]|\*+[^*/])*\*+"/" {/*comment*/}
"program" return PROGRAM;
"=" return EQ;
";" return SEMI;
"write" return WRITE;
"+" return ADD;
"-" return SUB;
"*" return MUL;
"%" return MOD;
"/" return DIV;
"{" return LBRACE;
"}" return RBRACE;
"(" return LP;
")" return RP;
[a-z] {yylval = (yytext[0] % 26); return IDENT;}
[0-9]+ {yylval = atoi(yytext); return NUM;}
[\t\s\n]+ {}
. {}


