#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 directory list_file"
    exit 1
fi

dir=$1
file_list=$2

if [ ! -d "$dir" ]; then
    echo "Error: directory '$dir' does not exist."
    exit 1
fi

if [ ! -f "$file_list" ]; then
    echo "Error: list file '$file_list' does not exist."
    exit 1
fi

while read -r name; do
    if [ -n "$name" ]; then
        path="$dir/$name"
        if [ ! -e "$path" ]; then
            touch "$path"
            chmod a-w "$path"
            echo "Created $path (write-protected)."
        fi
    fi
done < "$file_list"

