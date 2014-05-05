#!/bin/bash
./compile.sh

NUM_TESTS=33

for i in $(eval echo "{1..$NUM_TESTS}") ; do
    echo "Running test $i"
    ./ijparser -s -t < tests/test$i.txt
done

