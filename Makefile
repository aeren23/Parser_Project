all:
	bison -d parser.y
	flex parser.l
	gcc -o parser parser.tab.c lex.yy.c -lfl

clean:
	rm -f parser parser.tab.c parser.tab.h lex.yy.c
