# parm for files
PROGRAM=yacc1
LEX_SRC=./src/$(PROGRAM).l
YACC_SRC=./src/$(PROGRAM).y
LEX_OUT=lex.yy.c
YACC_OUT=y.tab.c
TEST_FILE=test_cases/*             
LIBS = 
HEADERS_LINKS = ./ident.h ./stack.h

# compliers                        
LEX=flex     
YACC=yacc
CC=gcc
DEBUGGER=gdb

#CC flags
CC_FLAGS=-ll -ly -Wall -I./headers

all : $(PROGRAM)

debug: $(YACC_OUT)
	$(CC) $(YACC_OUT) $(CC_FLAGS) -o $(PROGRAM) -g$$(DEBUGGER)

$(PROGRAM) : $(YACC_OUT) 
	$(CC) $(YACC_OUT) $(CC_FLAGS) -o $(PROGRAM)

$(YACC_OUT): $(YACC_SRC) $(LEX_OUT)
	$(YACC) $(YACC_SRC)

$(LEX_OUT) : $(LEX_SRC) $(LIBS)
	$(LEX) $(LEX_SRC)

clean : 
	rm -r *.c *.h *~ src/*~ $(PROGRAM)*
