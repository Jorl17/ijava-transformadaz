lex ijparser.l && yacc --defines=y.tab.h ijparser.y && gcc -g -ll -ly -o ijparser lex.yy.c y.tab.c
