#!/usr/bin/python

import argparse
import correlation
import os
import scipy.stats


def main():
    options = argparse.ArgumentParser(description='get maximum correlation across files')
    options.add_argument('-j', '--results-file', help='results file', required=True)
    options.add_argument('-d', '--directory', help='directory of files', required=True)
    options.add_argument('-c', '--correlation', choices=['pearson', 'kendall'], help='type of correlation',
                         default='pearson')
    args = options.parse_args()

    cor = scipy.stats.pearsonr if args.correlation == 'pearson' else scipy.stats.kendalltau

    max_params = ''
    max_c = 0.0
    max_sig = 0.0
    for param_setting in os.listdir(args.directory):
        file_path = os.path.join(args.directory, param_setting)
        if os.path.isdir(file_path):
            continue
        c, sig = correlation.compute(file_path, args.results_file,
                            cor, significance=True)
        if abs(c) > abs(max_c):
            max_c = c
            max_sig = sig
            max_params = param_setting

    print('Maximum correlation: {} (p = {}). Params: {}'.format(str(max_c), str(max_sig), max_params))


if __name__ == '__main__':
    main()