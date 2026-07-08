#!/bin/bash

# For two given directory trees ($1 and $2), create a third one ($3) representing their intersection.
# To create a copy, files/directories/symlinks must share the same name (relative path) and type in both trees.
# The content of regular files or the target of symlinks is irrelevant for comparison, but relevant for copying.
# The copy is always sourced from the first directory tree ($1).

if [ $# -ne 3 ]; then
    echo "Usage: $0 directory1 directory2 new_directory."
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Error: argument 1 is not a directory or does not exist." 
    exit 2
fi

if [ ! -d "$2" ]; then
    echo "Error: argument 2 is not a directory or does not exist." 
    exit 3
fi

dir1=$(readlink -f "$1")
dir2=$(readlink -f "$2")
new_dir=$(readlink -f "$3")

if [ "$dir1" = "$new_dir" ] -o [ "$dir2" = "$new_dir" ]; then
    echo "Error: new directory cannot be the same as any source directory." 
    exit 4
fi


mkdir -p "$new_dir"
if [ $? -ne 0 ]; then
    echo "Error: failed to create the destination directory."
    exit 5
fi


find "$dir1" -mindepth 1 -printf "%y\0%P\0" | while read -r -d '' type && read -r -d '' path; do

    from_dir1="$dir1/$path"
    from_dir2="$dir2/$path"
    to_new_dir="$new_dir/$path"

    case "$type" in
        d)
            if [ -d "$from_dir2" ] && [ ! -L "$from_dir2" ]; then
                mkdir -p "$to_new_dir"
            fi
            ;;
        f)
            if [ -f "$from_dir2" ] && [ ! -L "$from_dir2" ]; then
                mkdir -p "$(dirname "$to_new_dir")"
                cp "$from_dir1" "$to_new_dir"
            fi
            ;;
        l)
            if [ -L "$from_dir2" ]; then
                mkdir -p "$(dirname "$to_new_dir")"
                cp -d "$from_dir1" "$to_new_dir"
            fi
            ;;
    esac

done
