%{
int lines=0;
%}

%%
auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while {printf("reserved\n");}
[_|a-z|A-Z][a-z|A-Z|0-9|_]* {printf("l.%d\tIDENT: %s\n",lines,yytext);}
[0-9]+\.?[0-9]* {printf("Number\n",yytext);}
^\#.* {printf("#line\n");}
[\s\t]+ {}
\n {lines++;}
.+ {}
%%
main(){
    while(yylex() != 0){}
}
