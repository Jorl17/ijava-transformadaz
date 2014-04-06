lex ijscanner.l
yacc -d ijscanner.y
gcc -g -o ijscanner lex.yy.c y.tab.c