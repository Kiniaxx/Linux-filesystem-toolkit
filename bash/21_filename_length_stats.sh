#!/bin/bash

# Calculate the average length of file names in a given directory tree, grouped by file type (regular files, subdirectories, links)
# and the rules for calculating the average (full names, names with all extensions removed, names with the last extension removed).
# Note: A dot at the beginning of a file name does not denote an extension.

if [ $# -ne 1 ]; then
    echo "Usage: $0 directory_tree_name"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Error: directory does not exist"
    exit 2
fi

directory=$(readlink -f "$1")

find "$directory" -mindepth 1 -printf "%y %f\n" | awk '
{
    type = $1;
    full_name = $2;
    
    if (full_name == "") {
        next;
    }

    name_no_last_ext = full_name;
    if (substr(full_name, 1, 1) != ".") {
        sub(/\.[^.]*$/, "", name_no_last_ext);
    }
    
    name_no_ext_at_all = full_name;
    if (substr(full_name, 1, 1) != ".") {
        sub(/\..*$/, "", name_no_ext_at_all);
    }
   
    total_len[type "_full"] += length(full_name);
    total_len[type "_last_ext"] += length(name_no_last_ext);
    total_len[type "_all_ext"] += length(name_no_ext_at_all);
    count[type]++;
}
END {  
    print "File type | Naming rule | average length";
    print "---|---|---";
    
    TYPES["f"] = "Regular file";
    TYPES["d"] = "Directory";
    TYPES["l"] = "Symbolic link";
 
    for (t in count) {
        avg = (count[t] > 0) ? (total_len[t "_full"] / count[t]) : 0;
        printf "%s | Full name | %.2f\n", TYPES[t], avg;
    }
    
    for (t in count) {
        avg = (count[t] > 0) ? (total_len[t "_last_ext"] / count[t]) : 0;
        printf "%s | Without last ext | %.2f\n", TYPES[t], avg;
    }

    for (t in count) {
        avg = (count[t] > 0) ? (total_len[t "_all_ext"] / count[t]) : 0;
        printf "%s | Wtihout all ext | %.2f\n", TYPES[t], avg;
    }
}'
