#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 directory file_list"
    exit 1
fi

dir=$1
file_list=$2

if [ ! -d "$dir" ] || [ ! -f "$file_list" ]; then
    echo "Error: directory or list file does not exist."
    exit 1
fi

echo "Missing files:"
while read -r file; do
    [ -z "$file" ] && continue
    if [ ! -f "$dir/$file" ]; then
        echo "  $file"
    fi
done < "$file_list"

echo "Extra files (not in the list):"
for p in "$dir"/*; do
	filename=$(basename "$p")
    if ! grep -qx "$filename" "$file_list"; then
        echo "  $filename"
    fi
done

