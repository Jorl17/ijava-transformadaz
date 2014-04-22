#!/bin/bash
./compile.sh

NUM_TESTS=11

for i in $(eval echo "{1..$NUM_TESTS}") ; do
    echo "Running test $i"
    ./ijscanner < tests/test$i.txt
done

