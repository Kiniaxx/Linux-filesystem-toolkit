#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 directory log_file"
    exit 1
fi

dir=$1
log=$2

if [ ! -d "$dir" ]; then
    echo "Error: directory does not exist."
    exit 1
fi

rm -f "$log"

for file in "$dir"/*; do
    if [ -f "$file" ] && [ ! -L "$file" ] && [ ! -s "$file" ]; then
        echo "$(basename "$file")" >> "$log"
        rm "$file"
    fi
done

echo "Deleted empty files. The list can be found in $log."

