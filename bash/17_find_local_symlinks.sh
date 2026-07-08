#!/bin/bash

# [PL] W zadanym katalogu ($1) znajdź podkatalogi, zawierające dowiązania symboliczne do obiektów w tym katalogu ($1).

# [EN] In a given directory ($1), find subdirectories containing symbolic links to objects within that directory ($1).

if [ $# -ne 1 ]; then
	echo "Usage: $0 directory"
	exit 1
fi

if [ ! -d "$1" ]; then 
	echo "Eooro: directory does not exist"
	exit 2
fi 

dir=$(readlink -f "$1")

for item in "$dir"/*; do
    if [ -d "$item" ] && [ ! -L "$item" ]; then
        for file in "$item"/*; do
            if [ -L "$file" ]; then
                target=$(readlink -f "$file")

                case "$target" in
                    "$dir"/*)
			    echo "Subdirectory $(basename "$item") contains symlink $(basename "$file")"
                        ;;
                esac
            fi
        done
    fi
done
