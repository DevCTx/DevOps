#!/bin/bash

echo "# Create test files"
echo "Hello" > file.txt
echo "the" >> file.txt
echo "world" >> file.txt

echo "Alice,30,Paris" > data.csv
echo "Bob,25,Lyon" >> data.csv
echo "Charly,10,Marseille" >> data.csv

echo "# Line by line — file.txt"
while read line; do
    echo "$line"
done < file.txt

echo ""
echo "# CSV avec IFS — data.csv"
while IFS=',' read col1 col2 col3; do
    echo "$col1 | $col2 | $col3"
done < data.csv

echo ""
echo "# Full file in variable"
content=$(<file.txt)
echo "$content"

echo ""
echo "# Filter lines containing 'o'"
while read line; do
    if [[ "$line" == *o* ]]; then
        echo "Match: $line"
    fi
done < file.txt
