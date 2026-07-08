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
        found_executable=0
        for file in "$subdir"/*; do
            [ -e "$file" ] || continue
            if [ -f "$file" ] && [ -x "$file" ]; then
                found_executable=1
                break
            fi
            if [ -L "$file" ] && [ -x "$(readlink -f "$file")" ]; then
                found_executable=1
                break
            fi
        done
        if [ $found_executable -eq 0 ]; then
            echo "$(basename "$subdir")"
        fi
    fi
done

