#!/bin/bash

if [ $# -lt 2 ]; then
	echo "Missing required arguments (two are needed: directory name and file extension)"
	exit 1
fi

directory=$1
extension=$2
output_file="merged.txt"

if [ ! -d "$directory" ]; then
	echo "The specified directory does not exist"
	exit 1
fi


rm -f "$output_file"

for file in "$directory"/*."$extension"; do
    if [ -f "$file" ]; then
        echo "----- $(basename "$file") -------" >> "$output_file"
        cat "$file" >> "$output_file"
    fi
done

echo "Results saved in file $output_file"
