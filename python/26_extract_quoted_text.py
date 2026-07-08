#!/usr/bin/env python3

# Within a given text file, find and list all quoted texts on the screen (those enclosed in pairs of '‘' characters). It should account foe the fact that there can be multiple quoted texts in the same line, and that newlines may occur inside a quote.

import sys
import os
import re

QUOTE_CHAR = '‘'

def analyze_file(file_path):
    if not os.path.exists(file_path):
        print(f"Error: File '{file_path}' does not exist")
        return

    try:
        with open(file_path) as file:
            file_content = file.read()

        pattern = QUOTE_CHAR + r'(.*?)' + QUOTE_CHAR
        matches = re.finditer(pattern, file_content, re.DOTALL)

        found_any = False

        for match in matches:
            found_any = True
            quote_content = match.group(1)
            start_index = match.start()

            line_number = file_content.count('\n', 0, start_index) + 1

            print(f"Quote found at line: {line_number} :")
            print(f"{quote_content}")
            print("\n")


        if file_content.count(QUOTE_CHAR) % 2 != 0:
            print(f"Warning: there is an unclosed quote in the file.")

    except OSError as e:
        print(f"Error accessing file: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]}  file_name")
        sys.exit(1)

    analyze_file(sys.argv[1])

