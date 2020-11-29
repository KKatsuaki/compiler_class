%%
"var"      { return VAR;}
"main"     { return MAIN;}
"("        { return LPAR;}
")"        { return RPAR;}
","        { return COMMA;}
"{"        { return LBRA; }
"}"        { return RBRA; }
"write"    { return WRITE; }
"writeln"  { return WRITELN;}
";"        { return SEMI; }
"+"        { return PLUS; }
"-"        { return MINUS; }
"*"        { return MULT; }
"/"        { return DIV; }
"if"       { return IF; }
"then"     { return THEN;}
"else"     { return ELSE; }
"endif"    { return ENDIF; }
"while"    { return WHILE;}
"do"       { return DO; }
"read"     { return READ;}
":="       { return COLEQ;}
">="       { return GE; }
">"        { return GT; }
"<="       { return LE; }
"<"        { return LT; }
"!="       { return NE; }
"=="       { return EQ; }
"//".*|"/*"([^*]|\*+[^*/])*\*+"/" {/*comment*/}
[0-9]+     { yylval.val = atoi(yytext);return NUMBER; }
[a-z]+     {
yylval.name = malloc(sizeof(char) * strlen(yytext));
strcpy(yylval.name, yytext);
return ID;
}
[ \t]   {/*do nothing*/}
[\n] {lin++;}
.          {return yytext[0]; }
