#!/usr/bin/python

import argparse
import os
import random

from correlation_k_fold_validator import CorrelationKFoldValidator
from cross_validation.score_readers import ScoreReader


def main():
    options = argparse.ArgumentParser(description='run correlation cross-validation')
    options.add_argument('-d', '--directory', action='append', help='a directory of files, each of which is an item to '
                                                                   'be included in cross-validation; either this or '
                                                                   '-f must be specified', required=True)
    options.add_argument('-j', '--results-file', help='retrieval results file', required=True)
    options.add_argument('-k', '--folds', help='number of folds to use in cross-validation', default=10)
    options.add_argument('-r', '--seed', help='set the random seed for item shuffling', default=random.random())
    args = options.parse_args()

    reader = ScoreReader()
    for file in [os.path.join(directory, file) for directory in args.directory for file in os.listdir(directory) if
                 os.path.isfile(os.path.join(directory, file))]:
        reader.read(file, 'map')

    results = {}
    with open(args.results_file) as f:
        for line in f:
            parts = line.strip().split()
            results[parts[0]] = float(parts[1])

    # Run cross-validation
    validator = CorrelationKFoldValidator(results, num_folds=args.folds)
    scored_test_items = validator.cross_validate(*reader.scored_items(), seed=args.seed, verbose=True)

    # Output results
    for item in scored_test_items:
        print('{}\t{}'.format(item, str(scored_test_items[item])))


if __name__ == '__main__':
    main()
