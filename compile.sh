lex ijcompiler.l && yacc --defines=y.tab.h ijcompiler.y && gcc -g -o ijcompiler *.c -ll -ly
