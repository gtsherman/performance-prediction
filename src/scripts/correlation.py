#!/usr/bin/python

import argparse
import scipy.stats


def main():
    _pearson = 'pearson'
    _kendall = 'kendall'

    options = argparse.ArgumentParser(description='compute correlation of two runs')
    required = options.add_argument_group('required arguments')
    required.add_argument('-i', '--input', nargs=2, help='input file', required=True)
    required.add_argument('-c', '--correlation', choices=[_pearson, _kendall], help='type of correlation',
                          required=True)
    args = options.parse_args()

    cor = scipy.stats.pearsonr if args.correlation == _pearson else scipy.stats.kendalltau

    f1, f2 = {}, {}
    with open(args.input[0]) as f:
        for line in f:
            parts = line.strip().split()
            f1[parts[0]] = float(parts[1])

    with open(args.input[1]) as f:
        for line in f:
            parts = line.strip().split()
            f2[parts[0]] = float(parts[1])

    f1_order, f2_order = [], []
    for k in f1:
        if k not in f2:
            print('{} not in {}'.format(k, args.input[1]))
            exit()
        f1_order.append(f1[k])
        f2_order.append(f2[k])
    for k in f2:
        if k not in f1:
            print('{} not in {}'.format(k, args.input[0]))
            exit()

    print(str(cor(f1_order, f2_order)[0]))

if __name__ == '__main__':
    main()
