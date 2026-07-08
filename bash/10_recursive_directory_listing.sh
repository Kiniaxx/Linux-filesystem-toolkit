#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 directory max_depth"
    exit 1
fi

dir=$1
max_depth=$2

if [ ! -d "$dir" ]; then
    echo "Error: directory '$dir' does not exist."
    exit 1
fi

list_dir() {
    local_dir=$1
    depth=$2
    rel=$(realpath --relative-to="$dir" "$local_dir")

    for f in "$local_dir"/*; do
        [ ! -e "$f" ] && continue
        name=$(basename "$f")
        path="$rel/$name"
        [ "$rel" = "." ] && path="$name"
        if [ -f "$f" ]; then
            echo "$path"
        elif [ -d "$f" ] && [ $depth -lt $max_depth ]; then
            list_dir "$f" $((depth + 1))
        fi
    done
}

list_dir "$dir" 0

