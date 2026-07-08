#!/usr/bin/env python3

# In the given directory convert all symbolic links that points to regular files 
# (for which the user rinning the script does not have write permission)
# so that the symbolic links become absolute

import os
import sys

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: '{sys.argv[0]}' direcotry_name")
        sys.exit(1)
        
    dir = sys.argv[1] 
    
    if not os.path.isdir(dir):
        print(f"Error: directory does not exist")
        sys.exit(2)
    
    else:

        for filename in os.listdir(dir):
     
            symlink_path = os.path.join(dir, filename)
        
            if not os.path.islink(symlink_path):
                continue

            try:
                relative_target = os.readlink(symlink_path)
                absolute_target = os.path.realpath(symlink_path) 

                if not os.path.isfile(absolute_target):
                    continue
                
                if os.access(absolute_target, os.W_OK):
                    continue
                
                if os.path.isabs(relative_target):
                    continue
                 

                os.remove(symlink_path)
                os.symlink(absolute_target, symlink_path)
            
                print(f"Modified: '{filename}'. New target: {absolute_target}")

            except OSError as e:
                print(f"Error: {e}")
