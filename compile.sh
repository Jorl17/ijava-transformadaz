lex ijparser.l && yacc --defines=y.tab.h ijparser.y && gcc -g -o ijparser lex.yy.c y.tab.c -ll -ly
