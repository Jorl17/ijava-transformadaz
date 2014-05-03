#!/bin/bash

NUM_TESTS=34

for i in $(eval echo "{1..$NUM_TESTS}") ; do
    echo "Running test $i"
    ./ijparser.jn -s < tests/test$i.txt
done

