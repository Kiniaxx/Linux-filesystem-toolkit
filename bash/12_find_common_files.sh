#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 directory1 directory2"
    exit 1
fi

dir1=$1
dir2=$2

if [ ! -d "$dir1" ] || [ ! -d "$dir2" ]; then
    echo "Error: both directories must exist."
    exit 1
fi

echo "Files with identical names:"
for file in "$dir1"/*; do
    name=$(basename "$file")
    if [ -f "$file" ] && [ -f "$dir2/$name" ]; then
        echo "  $name"
    fi
done

