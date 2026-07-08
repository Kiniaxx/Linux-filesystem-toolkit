#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 list_file"
    exit 1
fi

file_list=$1
if [ ! -f "$file_list" ]; then
    echo "Error: list file does not exist."
    exit 1
fi

output_file="$file_list.output"
rm -f "$output_file"

while read -r file; do
    [ -z "$file" ] && continue
    if [ -f "$file" ]; then
        echo "------ $file -------" >> "$output_file"
        cat "$file" >> "$output_file"
    fi
done < "$file_list"

echo "Result saved in $output_file"

