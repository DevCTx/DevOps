#!/bin/bash

echo "sum 200 300 with return"
function first_sum() {
    total=$(($1 + $2))
    return $total        # 500 % 256 = 244
}
result=$(first_sum 200 300)
echo "Return code: $?"   # 244 (trunked)
echo "result: $result"   # empty



echo "sum 200 300 with echo"
function second_sum() {
    total=$(($1 + $2))
    echo $total
}
result=$(second_sum 200 300)
echo "Return code: $?"   # 0
echo "result: $result"   # 500
