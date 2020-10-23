CC=gcc
LEX=flex
YACC=yacc
DEBUGGER=gdb
CFLAGS=-ll -ly -Wall

C :
	$(LEX) C.l
	$(CC) $(CFLAGS) lex.yy.c -o C
	cat ./test_case.txt | ./C
C_1:
	$(LEX) C_1.l
	$(CC) $(CFLAGS) lex.yy.c -o C_1

C_2:
	$(LEX) C_2.l
	$(CC) $(CFLAGS) lex.yy.c -o C_2

C_3:
	$(LEX) C_3.l
	$(CC) $(CFLAGS) lex.yy.c -o C_3

C_4:
	$(LEX) C_4.l
	$(CC) $(CFLAGS) lex.yy.c -o C_4

C_5:
	$(LEX) C_5.l
	$(CC) $(CFLAGS) lex.yy.c -o C_5

clean:
	@rm `ls | grep -v .l | grep -v Makefile | grep -v test_cases.txt`
