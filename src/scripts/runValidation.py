#!/usr/bin/python

import argparse
import correlation
import os
import random
import scipy.stats

from correlation_k_fold_validator import CorrelationKFoldValidator
from cross_validation.score_readers import ScoreReader


def main():
    options = argparse.ArgumentParser(description='run correlation cross-validation')
    options.add_argument('-d', '--directory', action='append', help='a directory of files, each of which is an item to '
                                                                   'be included in cross-validation; either this or '
                                                                   '-f must be specified', required=True)
    options.add_argument('-j', '--results-file', help='retrieval results file', required=True)
    #options.add_argument('-k', '--folds', help='number of folds to use in cross-validation', default=10)
    options.add_argument('-c', '--correlation', choices=['pearson', 'kendall'], help='type of correlation',
                         default='pearson')
    options.add_argument('-r', '--seed', help='set the random seed for item shuffling', default=random.random())
    options.add_argument('-m', '--multi', action='store_true')
    args = options.parse_args()

    if args.multi: # run repeatedly
        for s in xrange(0, 100):
            c, p = validate(args.directory, args.results_file, args.correlation, s)
            print('{}\t{}\t{}'.format(str(s), str(c), str(p)))
    else: # just a normal single train/test
        c, p = validate(args.directory, args.results_file, args.correlation, args.seed)

        print('Correlation: {}'.format(str(c)))
        print('Significance: {}'.format(str(p)))


def validate(directory, results_file, crlation, seed):
    reader = ScoreReader()
    for file in [os.path.join(directory, file) for directory in directory for file in os.listdir(directory) if
                 os.path.isfile(os.path.join(directory, file))]:
        reader.read(file, None)

    results = {}
    with open(results_file) as f:
        for line in f:
            parts = line.strip().split()
            results[parts[0]] = float(parts[1])

    # Run cross-validation
    validator = CorrelationKFoldValidator(results, correlation=crlation, verbose=True)
    scored_test_items = validator.cross_validate(*reader.scored_items(), seed=seed, concatenate=False)

    # Output results
    #for item in scored_test_items[1]:
    #    print('{}\t{}'.format(item, str(scored_test_items[1][item])))

    cor = scipy.stats.pearsonr if correlation == 'pearson' else scipy.stats.kendalltau
    c, p = correlation.correlate(results, scored_test_items, cor, sig=True)
    return (c, p)

if __name__ == '__main__':
    main()
