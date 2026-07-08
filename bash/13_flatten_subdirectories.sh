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

for subdir in "$dir"/*; do
    if [ -d "$subdir" ]; then
        for file in "$subdir"/*; do
            [ -e "$file" ] && mv "$file" "$dir/"
        done
        rmdir "$subdir"
    fi
done

echo "Removed subdirectories (1 level deep)."

