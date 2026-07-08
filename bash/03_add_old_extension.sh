#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 directory"
    exit 1
fi

dir=$1

if [ ! -d "$dir" ]; then
    echo "Error: directory '$dir' does not exist."
    exit 1
fi

# 1. Delete all existing .old files
for file in "$dir"/*.old; do
    if [ -f "$file" ]; then
        rm "$file"
    fi
done

# 2. Rename remaining readable and writable (rw) files
for file in "$dir"/*; do
    if [ -f "$file" ] && [ -r "$file" ] && [ -w "$file" ]; then
        mv "$file" "$file.old"
    fi
done

echo "Successfully renamed matching files in $dir."

