# parm for files
PROGRAM=day3
LEX_SRC=$(PROGRAM).l
YACC_SRC=$(PROGRAM).y
YACC_OUT=y.tab.c
LEX_OUT=lex.yy.c
TEST_FILE=test.ex

# compliers
LEX=flex
YACC=yacc
CC=gcc
CFLAGS = -Wall -ll -ly

all: $(PROGRAM)

status:
	@$(LEX) --version
	@echo	
	@$(YACC) --version
	@echo
	@$(CC) --version

$(PROGRAM) : $(YACC_OUT)
	$(CC) $(YACC_OUT) -o $(PROGRAM) $(CFLAGS)

$(LEX_OUT) : $(LEX_SRC)
	$(LEX) $(LEX_SRC)

$(YACC_OUT): $(YACC_SRC) $(LEX_OUT)
	$(YACC) $(YACC_SRC)

test:	$(PROGRAM)
	./$(PROGRAM) $(TEST_FILE)

clean:
	@rm *.c *~

distclean:
	@rm *.c *~ $(PROGRAM)
