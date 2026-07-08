#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 directory"
    exit 1
fi

dir=$1
if [ ! -d "$dir" ]; then
    echo "Error: directory does not exist."
    exit 1
fi

for file in "$dir"/*; do
    if [ -f "$file" ] && [ -w "$file" ]; then
        touch "$file"
    fi
done

echo "Updated modification timestamps."

