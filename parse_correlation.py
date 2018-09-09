#!/usr/bin/env python
import argparse
import pandas as pd
from sys import stdin, stdout
from contextlib import suppress
from collections import defaultdict

parser = argparse.ArgumentParser()
parser.add_argument('-u', '--upper', help='Upper threshold value (e.g., 0.5).', type=float, required=True)
parser.add_argument('-l', '--lower', help='Lower threshold value (e.g., -0.5).', type=float, required=True)
parser.add_argument('-d', '--delimiter', help='Delimiting character of the input and output CSV file.', type=str, default=',', required=False)
parser.add_argument('-i', '--ignore_self', action='store_true', help='Ignore self correlated columns.', required=False)
parser.add_argument('-e', '--exclude_symmetry', action='store_true', help='Exclude symmetric values. This option uses caching and therefore is not suitable for large files.', required=False)

cache = defaultdict(dict)
threshold = 0.5

def try_str_to_float(str_in: str):
    try:
        return float(str_in)
    except ValueError:
        return None

if __name__ == '__main__':
    args = parser.parse_args()
    lines = []
    columns = []
    while True:
        line = stdin.readline()
        if not line:
            break
        lines.append(line)
        if len(lines) > 1:
            # First cell is index (column name)
            cells = line.split(args.delimiter)
            index = cells[0]
            values = list(map(try_str_to_float, cells[1:]))
            assert len(values) == len(columns)
            for column, value in zip(columns, values):
                # Ignore self correlated columns
                if args.ignore_self and column == index:
                    continue
                # Exclude symmetric values
                if args.exclude_symmetry:
                    with suppress(KeyError):
                        cache[index][column]
                        continue
                # Ignore TypeErrors due to None values
                with suppress(TypeError):
                    if value > args.upper or value < args.lower:
                        stdout.write(args.delimiter.join([column, index, str(value)]) + '\n')
                        stdout.flush()
                        cache[column][index] = value
        else:
            # Strip leading and trailing whitespace and newlines
            # Note that first value in the header is empty
            columns = [c.strip() for c in line.split(args.delimiter)[1:]]
            # Write header line to stdout
            stdout.write(args.delimiter.join(['col1', 'col2', 'value']) + '\n')