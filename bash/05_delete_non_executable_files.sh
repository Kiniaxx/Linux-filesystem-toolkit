#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 directory"
    exit 1
fi

dir=$1

if [ ! -d "$dir" ]; then
    echo "Error: directory '$dir' does not exist"
    exit 1
fi

for file in "$dir"/*; do
    if [ -f "$file" ] && [ ! -x "$file" ]; then
        rm "$file"
    fi
done

echo "Removed all non-executable files in $dir."

