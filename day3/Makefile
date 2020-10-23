# parm for files
LEX_SRC=lex_file.l
LEX_OUT=lex.yy.c
YACC_SRC=yacc_file.y
YACC_OUT=y.tab.c 
PROGRAM=a.out
TEST_FILE=test.ex

# compliers
LEX=flex
YACC=yacc
CC=gcc

all: $(PROGRAM)

status:
	@$(LEX) --version
	@echo	
	@$(YACC) --version
	@echo
	@$(CC) --version

$(PROGRAM) : $(YACC_OUT)
	@$(CC) $(YACC_OUT) -ll -ly -o $(PROGRAM) --no-warnings

$(LEX_OUT) : $(LEX_SRC)
	@$(LEX) $(LEX_SRC)

$(YACC_OUT): $(YACC_SRC) $(LEX_OUT)
	@$(YACC) $(YACC_SRC)

test:	$(PROGRAM)
	@./$(PROGRAM) $(TEST_FILE)

clean:
	@rm *.c *~

distclean:
	@rm *.c *~ $(PROGRAM)
