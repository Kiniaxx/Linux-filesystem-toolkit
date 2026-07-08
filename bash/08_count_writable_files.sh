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

counter=0
for file in "$dir"/*; do
    if [ -f "$file" ] && [ -w "$file" ]; then
        counter=$((counter + 1))
    fi
done

echo "Number of writable files: $counter"

