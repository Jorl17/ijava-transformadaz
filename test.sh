#!/bin/bash
./compile.sh

NUM_TESTS=34

for i in $(eval echo "{1..$NUM_TESTS}") ; do
    echo "Running test $i"
    ./ijparser < tests/test$i.txt
done

