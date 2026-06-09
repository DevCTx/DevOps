#!/bin/bash
function check() {
    [[ -f "$1" ]] && return 1 || return 0
}

check "file.txt"

#report the last return
echo $? # 0 or 1
