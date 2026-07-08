#!/usr/bin/env python3

# Copy a given directory tree to a specified destination, including regular files, subdirectories,
# and symbolic links that point to objects inside the copied tree.
# Symbolic links in the copy should point to the newly copied objects.

import shutil
import sys
import os

def copy_tree(source, destination):

    source = os.path.realpath(source)
    destination = os.path.realpath(destination)

    if not os.path.exists(source):
        print(f"Error: directory {source} does not exist")
        return

    prefix_source = source if source.endswith(os.sep) else source + os.sep

    for root, dirs, files in os.walk(source):

        rel_path = os.path.relpath(root, source)
        
        if rel_path == ".":
            target_dir = destination
        else:
            target_dir = os.path.join(destination, rel_path)

        os.makedirs(target_dir, exist_ok=True)

        for name in files + dirs:
            src_path = os.path.join(root, name)
            dst_path = os.path.join(target_dir, name)

            if os.path.islink(src_path):
                link_target = os.path.realpath(src_path)
            
                if link_target.startswith(prefix_source) or link_target == source:
                    rel_target = os.path.relpath(link_target, source)
                    new_target = os.path.join(destination, rel_target)

                    if os.path.lexists(dst_path):
                        os.unlink(dst_path)
                    os.symlink(new_target, dst_path)
                    print(f"Internal symlink mapped: {name} -> {new_target}")

                else:
                    if os.path.lexists(dst_path):
                        os.unlink(dst_path)
                    os.symlink(os.readlink(src_path), dst_path)
                    print(f"External symlink copied: {name}")
    

            elif os.path.isfile(src_path):
                shutil.copy2(src_path, dst_path)
                print(f"Copied file: {name}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: '{sys.argv[0]}' source_dir destination_dir")
        sys.exit(1)

    copy_tree(sys.argv[1], sys.argv[2])
