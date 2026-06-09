#! /bin/bash
echo "# Basic read, enter name"
read name
echo "Hello $name"

echo "# With prompt, enter name"
read -p "Enter name: " name
echo "Hello $name"

echo "# Multiple variables, enter 2 values"
read first last
echo "$first $last"

echo "# Read password (hidden), enter a word"
read -s password
echo "$password"

echo "# With timeout, enter a word before 5s or timeout"
read -t 5 value  # 25 seconds
if [ $? -eq 0 ]; then
    echo "Saisi: $value"
else
    echo "Timeout!"
fi
