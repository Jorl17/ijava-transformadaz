#!/bin/bash

NUM_TESTS=31

for i in $(eval echo "{1..$NUM_TESTS}") ; do
    echo "Running test $i"
    ./ijparser.jn -t < tests/test$i.txt
done

