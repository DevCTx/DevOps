#!/bin/bash

function sum_return() {
  total=$(($1 + $2))
  return $total   # return does not work cause return can only be a 0-255 value
}

echo "sum_return 200 300"
sum_return 200 300
echo "Return code: $?"      # $? = 244 cause 500 % 256 = 244
echo "cause 500 % 256 = 244 : return can only be a 0-255 value"
echo

# ------------------------

function sum_echo() {
  total=$(($1 + $2))
  echo $total   # so echo is better for this situation
}

echo "sum_echo 200 300"
sum_echo 200 300
echo "Return code: $?"
