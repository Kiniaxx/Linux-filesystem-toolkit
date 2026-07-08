#!/usr/bin/env python3

# Within a given directory tree, find regular files that have hard links (whether inside
# or outside the tree), where the owner lacks write and execute permissions,
# group owners lack write permissions, and others have execute permissions.

import os
import sys
import stat

def analyze_tree(start_path):
    if not os.path.isdir(start_path):
        print(f"Error: '{start_path}' is not a directory.")
        return

    
    for root, dirs, files in os.walk(start_path):
        for filename in files:
            full_name = os.path.join(root, filename)
            
            try:
                info = os.lstat(full_name)
                mode = info.st_mode

                if not stat.S_ISREG(mode):
                    continue
                
                if info.st_nlink <= 1:
                    continue
                
                owner_no_wx = not (mode & stat.S_IWUSR) and not (mode & stat.S_IXUSR)
                
                group_no_w = not (mode & stat.S_IWGRP)
                
                others_x = bool(mode & stat.S_IXOTH)

                if owner_no_wx and group_no_w and others_x:
                    print(f"Found: {full_name}")
                    print(f"  - Hard links count: {info.st_nlink}")
                    print(f"  - Permissions (octal): {oct(stat.S_IMODE(mode))}")

            except OSError as e:
                print(f"Error accessing {full_name}: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: '{sys.argv[0]}' directory")
        sys.exit(1)
    
    analyze_tree(sys.argv[1])
