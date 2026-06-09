#!/bin/bash
i=0
while [ $i -lt 10 ]; do
    echo $i
    ((i++))
done

echo "hello" > file.txt
echo "the" >> file.txt
echo "world" >> file.txt

# Read file line by line
while read line; do
    echo $line
done < file.txt
