%%
auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while {printf("reserved");}
      [_|a-z|A-Z][a-z|A-Z|0-9|_]* {printf("%s\t",yytext);printf("l%d",lines);}
[0-9]+\.?[0-9]* {printf("Number\n");}
^\#.* {printf("#line");}
[ \t]+ {}
.+ {}
%%
main(){
    while(yylex() != 0){}
}
