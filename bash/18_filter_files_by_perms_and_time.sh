#!/bin/bash

# Within a given directory tree, list regular files where the owner lacks execute permissions,
# but someone else (group/others) has write permissions, modified no earlier than 5 minutes ago
# and no later than $2 (script argument) minutes ago.

if [ $# -ne 2 ]; then
    echo "Usage: $0 directory minutes."
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Error: directory does not exist."
    exit 2
fi

dir="$1"

if ! [[ "$2" =~ ^[0-9]+$ ]]; then
    echo "Error: the second argument must be a non-negaitve integer."
    exit 3
fi

minutes="$2"

if [ "$minutes" -gt 5 ]; then
    echo "Error: the second argument $minutes cannot be greater than 5"
    exit 4
fi


find "$dir" \
	-type f \
	! -perm /u=x \
	-perm /go=w \
	-mmin -5 \
	\( -mmin $minutes -o -mmin +$minutes \) \
	-print
