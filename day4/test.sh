#!/bin/sh

for file in `\find ./test_cases -maxdepth 1 -type f`; do
    /bin/echo -n $file " "
    /bin/echo $(./sem $file) 
done
