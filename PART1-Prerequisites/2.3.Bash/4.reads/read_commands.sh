#!/bin/bash

echo ""
echo "# Count the lines with pipe"
count=0
ls -l | while read line; do
    ((count++))
done
echo "Number of lines: $count (not incremented)"

echo "# Count the lines With process substitution"
count=0
while read line; do
    ((count++))
done < <(ls -l)
echo "Number of lines: $count (valid)"




