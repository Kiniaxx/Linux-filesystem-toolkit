#!/usr/bin/env python3

# In the specified directory, convert all symbolic links pointing to regular files within the same directory into hard links.

import os
import sys

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: '{sys.argv[0]}' directory_name")
        sys.exit(1)
        
    dir = sys.argv[1]
    
    if not os.path.isdir(dir):
        print(f"Error: directory does not exist")
        sys.exit(2)

    for item in os.listdir(dir):
        
        symlink_path = os.path.join(dir, item)
        
        if not os.path.islink(symlink_path):
            continue

        try:
            absolute_target = os.path.realpath(symlink_path)

            if not os.path.isfile(absolute_target):
                continue
                
            target_dir = os.path.dirname(absolute_target)
     
            if os.path.abspath(target_dir) != os.path.abspath(dir):
                 continue
             
                 
            os.remove(symlink_path)
            os.link(absolute_target, symlink_path)
            
            print(f"Modified: '{item}' to '{absolute_target}'")

        except OSError as e:
            print(f"Error: {e}")
