#!/bin/bash

# Two ways to declare
my_function() {
    echo "Hello $1"
}

function another_function {
    local result=$((${1} + ${2}))
    echo "(${1} + ${2}) = $result"
}

# Calling
my_function "World"
another_function 5 3
