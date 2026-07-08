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

ls -S -r "$dir" > /tmp/list$$

counter=1
while read -r file; do
    path="$dir/$file"
    if [ -f "$path" ] && [ -x "$path" ]; then
        mv "$path" "$path.$counter"
        counter=$((counter + 1))
    fi
done < /tmp/list$$

rm /tmp/list$$
echo "Successfully numbered executable files."

