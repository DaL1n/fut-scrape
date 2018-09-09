#!/usr/bin/env python
import argparse
import pandas as pd
import matplotlib
# Do not show figures on display
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from sys import stdin, stdout

parser = argparse.ArgumentParser()
parser.add_argument('-d', '--delimiter', help='Delimiting character of the input and output CSV file.', type=str, default=',', required=False)
parser.add_argument('-c', '--cols', help='Comma-separated list of correlated column names. If not specified, all columns are correlated.', type=str, default=None, required=False)
parser.add_argument('-g', '--graph', help='File name for correlation matrix graph. If None, no graph is generated.', type=str, default=None, required=False)



if __name__ == '__main__':
    args = parser.parse_args()
    # Read data from stdin
    df = pd.read_csv(stdin, sep=args.delimiter)
    # Columns to correlate
    cols = list(df)
    if args.cols is not None:
        # Separate by ',' and trim whitespace
        cols = [c.strip() for c in args.cols.split(',')]
    # Calculate correlation matrix for specified columns
    try:
        df_corr = df[cols].corr()
    except KeyError:
        raise ValueError(f'Invalid columns {cols}')
    # Write correlation matrix graph to file if specified
    if args.graph:
        plt.matshow(df_corr)
        plt.colorbar()
        plt.savefig(args.graph)
    # Write to stdout
    df_corr.to_csv(stdout, sep=args.delimiter)