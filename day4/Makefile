 # parm for files
PROGRAM=sem
LEX_SRC=./src/$(PROGRAM).l
YACC_SRC=./src/$(PROGRAM).y
TEST_FILE=test_cases/*

LEX_OUT=lex.yy.c
YACC_OUT=y.tab.c 

LIBS = ./lib/libstack.so ./lib/libident.so
LIBDIR=./lib
HEADERS_LINKS = ./ident.h ./stack.h
HEADERS=./headers

# compliers
LEX=flex
YACC=yacc
CC=gcc


#CC flags
CFLAGS=-ll -ly -Wall -I$(HEADERS)

all: $(PROGRAM)

status:
	@$(LEX) --version
	@echo	
	@$(YACC) --version
	@echo
	@$(CC) --version

debug : $(YACC_OUT) $(LIBS)
	$(CC) $(YACC_OUT) $(CFLAGS) -L $(LIBDIR) -lstack -lident -o $(PROGRAM) -ggdb

$(PROGRAM) : $(YACC_OUT)
	$(CC) $(YACC_OUT) $(CFLAGS) -L $(LIBDIR) -lstack -lident -o $(PROGRAM) 

$(YACC_OUT): $(YACC_SRC) $(LEX_OUT)
	$(YACC) $(YACC_SRC)	    

$(LEX_OUT) : $(LEX_SRC) $(LIBS)
	$(LEX) $(LEX_SRC) 

$(LIBS) : 
	mkdir $(LIBDIR)
	$(CC) -shared ./src/stack.c $(CFLAGS) -o ./lib/libstack.so
	$(CC) -shared ./src/ident.c $(CFLAGS) -o ./lib/libident.so
	ln -s headers/ident.h .
	ln -s headers/stack.h .

test:	$(PROGRAM)
	@sh test.sh

clean :
	rm -rf *.c *.h *~ src/*~ $(PROGRAM).*

distclean:
	rm -rf *.c *.h *~ src/*~ $(PROGRAM)* $(LIBDIR)

