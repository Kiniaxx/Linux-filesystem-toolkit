# **Linux-filesystem-toolkit**
Collection of Bash and Python command-line utilities for filesystem operations on Linux - permissions, symlinks/hardlinks, recursive traversal, and file management, written as part of operating systems programming coursework.

These scripts were written as part of the operating systems course and are shared here 
as a demonstration of scripting and Linux systems knowledge. Each tool is self-contained, 
uses only the POSIX/standard toolset (no external dependencies beyond the Python standard library), 
does its own argument validation, and prints a usage message when called incorrectly.

## **Requirements**
* Bash 4+ (Linux/macOS/WSL)
* Python 3.8+ (standard library only)
* Standard GNU coreutils / findutils (find, awk, readlink, ...)

## **Scripts**
| Script Name | Language | Description |
|---|---|---|
| 00_interactiveshell.sh | Bash | Basic interactive script demonstrating read/user input handling |
| 01_merge_files.sh | Bash | Merges all files with a given extension in a directory into a single output file, each prefixed with its filename |
| 02_move_executable_files.sh | Bash | Moves all executable files from a source directory to a destination directory |
| 03_add_old_extension.sh | Bash | Removes existing .old files, then renames all readable/writable files by appending .old|
| 04_create_readonly_files.sh | Bash | Creates empty, write-protected files listed in a text file, if they don't already exist |
| 05_delete_non_executable_files.sh | Bash | Deletes all non-executable regular files in a directory |
| 06_number_executables.sh | Bash | Renames executable files by appending a numeric suffix, ordered by file size |
| 07_compare_dir_with_list.sh | Bash | Compares a directory's contents against a reference list, reporting missing and extra files|
| 08_count_writable_files.sh | Bash | Counts writable regular files in a directory|
| 09_merge_files_from_list.sh | Bash | Merges files whose paths are given in a list file into a single output file |
| 10_recursive_directory_listing.sh | Bash | Recursively lists files in a directory tree up to a given depth |
| 11_delete_empty_files.sh | Bash | Deletes empty (zero-size) files and logs their names | 
| 12_find_common_files.sh | Bash | Lists files with identical names present in two directories |
| 13_flatten_subdirectories.sh | Bash | Moves files out of first-level subdirectories into the parent directory and removes the empty subdirectories |
| 14_find_common_files.sh | Bash | Removes files from one directory that also exist (by name) in another |
| 15_update_timestamps.sh | Bash | Updates modification timestamps of all writable files in a directory |
| 16_find_non_executable_subdirs.sh | Bash | Finds subdirectories that contain no executable files |
| 17_find_local_symlinks.sh | Bash | Finds subdirectories containing symlinks that point back into the parent directory |
| 18_filter_files_by_perms_and_time.sh | Bash | Finds files matching specific permission and modification-time criteria using find |
| 19_directory_intersection.sh | Bash | Builds a new directory tree representing the intersection (by name + type) of two directory trees | 
| 20_find_duplicate_filenames.sh | Bash | Finds files across a directory tree that share the same base name (ignoring extension) |
| 21_filename_lenght_stats.sh | Bash/awk | Computes average filename length per file type, under different naming rules |
| 22_convert_symlinks_to_absolute.py | Python | Converts relative symlinks (pointing to read-only files) into absolute symlinks | 
| 23_convert_symlinks_to_hardlinks.py | Python | Converts symlinks pointing to files within the same directory into hard links |
| 24_find_hardlinked_files_by_perms.py | Python | Finds hard-linked files matching a specific permission pattern within a directory tree |
| 25_copy_tree_with_internal_symlinks.py | Python | Copies a directory tree, correctly remapping internal symlinks to point into the new copy |
| 26_extract_quoted_text.py | Python | Extracts and lists all quoted text blocks (including multi-line quotes) from a text file |

## **Usage**
Each script prints a usage message when run without the required arguments:
```bash
chmod +x 01_merge_files.sh
./01_merge_files.sh <directory> <extension>
```

## **Skills**
* POSIX file permission model (owner/group/other, stat, chmod semantics)
* Symbolic vs. hard links, and safe link resolution (readlink, realpath)
* Recursive directory traversal (find, os.walk, manual recursion)
* Robust CLI scripts: argument validation, exit codes, usage messages
* Text processing with awk and Python re (multi-line pattern matching)
* Writing scripts that work correctly with paths containing spaces/special characters
