lex ijscanner.l
yacc -d -v ijscanner.y
gcc -g -o ijscanner lex.yy.c y.tab.c