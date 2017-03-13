#!/usr/bin/python

import argparse
import scipy.stats
import sys


def main():
    _pearson = 'pearson'
    _kendall = 'kendall'

    options = argparse.ArgumentParser(description='compute correlation of two runs')
    required = options.add_argument_group('required arguments')
    required.add_argument('-i', '--input', nargs=2, help='input file', required=True)
    required.add_argument('-c', '--correlation', choices=[_pearson, _kendall], help='type of correlation',
                          required=True)
    required.add_argument('-s', '--significance', action='store_true', help='include significance', default=False)
    args = options.parse_args()

    scipy.seterr(all='raise')
    cor = scipy.stats.pearsonr if args.correlation == _pearson else scipy.stats.kendalltau

    print(compute(args.input[0], args.input[1], cor, args.significance))


def compute(file1, file2, cor, significance):
    f1, f2 = {}, {}
    with open(file1) as f:
        for line in f:
            parts = line.strip().split()
            f1[parts[0]] = float(parts[1])

    with open(file2) as f:
        for line in f:
            parts = line.strip().split()
            f2[parts[0]] = float(parts[1])

    return correlate(f1, f2, cor, sig=significance)


def correlate(f1, f2, cor, sig=False):
    shared = set(f1.keys()) & set(f2.keys())

    f1_order, f2_order = [], []
    for k in shared:
        f1_order.append(f1[k])
        f2_order.append(f2[k])

    return cor(f1_order, f2_order)[0] if not sig else cor(f1_order, f2_order)


if __name__ == '__main__':
    main()
