 # parm for files
PROGRAM=sem
LEX_SRC=./src/$(PROGRAM).l
YACC_SRC=./src/$(PROGRAM).y
TEST_FILE=test_cases/*

LEX_OUT=lex.yy.c
YACC_OUT=y.tab.c 

OBJ=./obj/libstack.o ./obj/libident.o
OBJDIR=./obj
HEADERS_LINKS = ./ident.h ./stack.h
HEADERS=./headers

CC=gcc
DEBUGGER=gdb

#CC flags
CFLAGS=-Wall -I$(HEADERS)

all: $(PROGRAM)

status:
	@$(LEX) --version
	@echo	
	@$(YACC) --version
	@echo
	@$(CC) --version

debug : $(YACC_OUT) $(LEX_OUT) $(OBJ)
	$(CC) $(YACC_OUT) $(OBJ) -ly -ll  $(CFLAGS) -o $(PROGRAM) -g$(DEBUGGER)

$(PROGRAM) : $(YACC_OUT) $(LEX_OUT) $(OBJ)
	$(CC) $(YACC_OUT) $(OBJ) -ly -ll $(CFLAGS) -o $(PROGRAM) 

$(YACC_OUT): $(YACC_SRC)
	$(YACC) $(YACC_SRC)	    

$(LEX_OUT) : $(LEX_SRC)
	$(LEX) $(LEX_SRC) 

$(OBJ) : ./src/stack.c ./src/ident.c
	mkdir $(OBJDIR)
	$(CC) -c ./src/stack.c $(CFLAGS) -o $(OBJDIR)/libstack.o
	$(CC) -c ./src/ident.c $(CFLAGS) -o $(OBJDIR)/libident.o
	ln -s headers/ident.h .
	ln -s headers/stack.h .

test:	$(PROGRAM)
	@sh test.sh

clean :
	rm -rf *.c *.h *~ src/*~ $(PROGRAM).*

distclean:
	rm -rf *.c *.h *~ src/*~ $(PROGRAM)* $(OBJDIR)

