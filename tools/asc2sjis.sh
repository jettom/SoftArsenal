#!/bin/sh

tmp=".tmp"

for filename in `find . -type f -name \*.java`
do
    native2ascii -encoding Shift_JIS ${filename} ${filename}${tmp}

    native2ascii -reverse -encoding Shift_JIS ${filename}${tmp} ${filename}

    rm ${filename}${tmp}
done
