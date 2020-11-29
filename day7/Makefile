#YACC	= bison
#LEX	= flex
YACC	= yacc
LEX	= lex
CC	= gcc
#LFLAGS	= -ly -lfl -I./headers
LFLAGS	= -ly -ll -I./headers

OBJ = obj/code.o obj/env.o
OBJ_DIR=obj
PROGRAM = cmm

all : $(PROGRAM)

$(PROGRAM)	: y.tab.c $(OBJ)
	$(CC) y.tab.c $(OBJ) $(LFLAGS) -o cmm 
	@rm y.tab.c  lex.yy.c

y.tab.c	: src/cmm.y lex.yy.c
	$(YACC) src/cmm.y

$(OBJ)	: src/code.c src/env.c $(OBJ_DIR)
	$(CC) -c src/code.c -o obj/code.o $(LFLAGS) 
	$(CC) -c src/env.c -o obj/env.o $(LFLAGS) 

lex.yy.c	: src/cmm.l
	$(LEX) src/cmm.l

$(OBJ_DIR)	:
	mkdir obj

clean	:
	rm -rf *~ *.tab.* lex.yy.c obj code.output

cleanall	: clean
	rm -f cmm 

test	: $(PROGRAM) test.sh
	sh test.sh
	@rm -rf *~ *.tab.* lex.yy.c obj code.output
