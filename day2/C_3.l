%%
auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while {printf("reserved");}
      [0-9]+\.?[0-9]*{printf("Number\n");}
^\#.* {printf("#line");}
[\t\s\n]+ {}
.+ {}
%%
main(){
	  while(yylex() != 0){}
      }
