#!/bin/sh
for file in `\find ./test_files -maxdepth 1 -type f`; do
    echo $file
    cat $file
    echo
    ./cmm $file && pl0i
    echo
done
