 # parm for files
LEX_SRC=./src/sem.l
YACC_SRC=./src/sem.y
LEX_OUT=lex.yy.c
YACC_OUT=y.tab.c 
PROGRAM=sem
TEST_FILE=test_cases/*
LIBS = ./lib
HEADERS_LINKS = ./ident.h ./stack.h

# compliers
LEX=flex
YACC=yacc
CC=gcc

#CC flags
CC_FLAGS=-ll -ly -Wall  -I./headers 

all: $(PROGRAM)

status:
	@$(LEX) --version
	@echo	
	@$(YACC) --version
	@echo
	@$(CC) --version

debug : $(YACC_OUT) $(LIBS)
	$(CC) $(YACC_OUT) $(CC_FLAGS) -L $(LIBS) -lstack -lident -o $(PROGRAM) -ggdb

$(PROGRAM) : $(YACC_OUT)
	$(CC) $(YACC_OUT) $(CC_FLAGS) -L $(LIBS) -lstack -lident -o $(PROGRAM) 

$(YACC_OUT): $(YACC_SRC) $(LEX_OUT)
	$(YACC) $(YACC_SRC)	    

$(LEX_OUT) : $(LEX_SRC) $(LIBS)
	$(LEX) $(LEX_SRC) 

$(LIBS) : 
	mkdir $(LIBS)
	$(CC) -shared ./spppprc/stack.c $(CC_FLAGS) -o ./lib/libstack.so
	$(CC) -shared ./src/ident.c $(CC_FLAGS) -o ./lib/libident.so
	ln -s headers/ident.h .
	ln -s headers/stack.h .

test:	$(PROGRAM)
	@sh test.sh

clean :
	rm -r *.c *.h *~ src/*~ $(PROGRAM).*
