lex ijparser.l && yacc --defines=y.tab.h ijparser.y && gcc -Wall -g -o ijparser *.c -ll -ly
