#!/bin/bash
TESTFILE=tests/test.txt
lex ijscanner.l && gcc lex.yy.c -o ijscanner && ./ijscanner < $TESTFILE
