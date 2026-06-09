#!/bin/bash

echo "# Iterate over list"
for item in file1 file2 file3; do
    echo $item
done

echo "# Range (C-style)"
for ((i=0; i<10; i++)); do
    echo $i
done

echo "# Array"
arr=(a b c)
for item in "${arr[@]}"; do
    echo $item
done
