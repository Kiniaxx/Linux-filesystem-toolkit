#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 source_directory destination_directory"
    exit 1
fi

src=$1
dst=$2

if [ ! -d "$src" ] || [ ! -d "$dst" ]; then
    echo "Error: both directories must exist."
    exit 1
fi

for file in "$src"/*; do
    if [ -f "$file" ] && [ -x "$file" ]; then
        mv "$file" "$dst"
    fi
done

echo "Moved executable files from $src to $dst."

