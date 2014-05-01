lex ijparser.l && yacc --defines=y.tab.h ijparser.y && gcc -g -o ijparser *.c -ll -ly
