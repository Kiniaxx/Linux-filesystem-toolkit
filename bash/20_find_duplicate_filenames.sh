#!/bin/bash

# Within a given directory tree, find duplicate file names (ignoring extensions)
# and list them grouped by their names (the duplicate name followed by the paths where it appears).

if [ $# -ne 1 ]; then
	echo "Usage: $0 directory"
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "Error: target is not a directory or does not exist."
	exit 2
fi

dir=$(readlink -f "$1")
echo "$dir"
echo
 
find "$dir" -type f -print | awk '{
    full_path = $0;
    filename = $0;
    gsub(/.*\//, "", filename);
    split(filename, parts, ".");
    base_name = parts[1];

    if (base_name == "") {
        next;
    }

    paths[base_name] = paths[base_name] full_path "\n";
    count[base_name]++;
}
END {
    for ( name in count ) {
        if (count[name] > 1 ) {
		print "------------------------------------------------";
           	print "Duplicate base name found: " name;
            	printf "%s", paths[name];
        }
    }
}'
