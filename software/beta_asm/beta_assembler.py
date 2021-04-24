#!/usr/bin/python

"""
THIS FILE IS A COPY OF https://github.com/waliens/cli-beta-assembler/blob/master/beta/test_program.py
from Romain Mormont with few modifications to fit the project.
"""

import os
from argparse import ArgumentParser

from beta.assembler.assembler import assemble
from beta.assembler.exceptions import UnknownIdentifierError
from beta.parsing import BetaAssemblySyntaxError, parse_file
from beta.parsing.exceptions import IncludeFileNotFoundError

def display_name(filepath, fullpath=False):
    if not fullpath:
        return os.path.basename(filepath)
    return filepath

def error_header(filepath, line, col, fullpath=False):
    return "in file \"{}\" ({}:{})".format(display_name(filepath, fullpath=fullpath), line, col)

def save_bin_file(bytes):
    f = open("out.bin", "wb")
    for byte in bytes:
        f.write(byte.to_bytes(1, byteorder='big', signed=False))
    f.close()
    	
def main(argv):
    parser = ArgumentParser(description='Parse beta assembly file')
    parser.add_argument("--filepath", dest="filepath", help="Path to the root assembly file.")
    parser.add_argument("--fullpath", dest="fullpath", action="store_true",
                        help="True for showing full path in logs, false for showing only ")
    parser.set_defaults(fullpath=False)
    params, _ = parser.parse_known_args(argv)

    filepath = params.filepath
    displayable = display_name(filepath, fullpath=params.fullpath)

    try:
        print("Process file '{}'...".format(displayable))
        print("Parsing... ", end="")
        tree, parse_table = parse_file(filepath, parsed_files=[filepath])
        print("success")
        print(" -> {} identifier(s) found".format(len(parse_table.variables)))
        print(" -> {} macro(s) found".format(len(parse_table.macros)))
        print("Assembling... ", end="")
        bytes, breakpoints = assemble(filepath)
        print("success")
        print(" -> {} bytes generated".format(len(bytes)))
        print("Saving binary file... ", end="")
        save_bin_file(bytes)
        print("success")
        return 0
    except IOError as e:
        print("error: couldn't process the file '{}': {}".format(
            display_name(e.filename, fullpath=params.fullpath), e.strerror
        ), file=sys.stderr)
    except IncludeFileNotFoundError as e:
        header = error_header(e.source, e.line, e.col, fullpath=params.fullpath)
        print("error: {} : {}".format(header, e.msg), file=sys.stderr)
    except BetaAssemblySyntaxError as e:
        curr_file = e._recognizer._parsed_files[-1]
        header = error_header(curr_file, e._line, e._column, fullpath=params.fullpath)
        print("error: {} : {}".format(header, e._msg), file=sys.stderr)
    except UnknownIdentifierError as e:
        header = error_header(e.source, e.line, e.col, fullpath=params.fullpath)
        print("error: {} : {}".format(header, e.msg))
    exit(-1)  # an error occurred


if __name__ == "__main__":
    import sys
    main(sys.argv[1:])