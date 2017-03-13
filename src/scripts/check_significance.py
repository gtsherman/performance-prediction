#!/usr/bin/python

from correlation import compute
import scipy.stats
import sys

to_check = sys.argv[1]

with open(to_check) as f:
    for line in f:
        if '_' in line:
            bits = line.strip().split('_')
            col, pred, metric, cor = bits[0], bits[1], bits[3], bits[4]
        else:
            bits = line.strip().split(' ')
            if pred == 'pseudoScore':
                name = 'self.stopped/{}/n{}.k{}.p{}'.format(metric, bits[0], bits[1], bits[2])
            else:
                name = 'd{}.t{}'.format(bits[0], bits[1])

            metric_results = metric
            if metric == 'ndcg':
                metric_results == 'ndcg_cut_20'

            cor = scipy.stats.pearsonr if cor == 'pearson' else scipy.stats.kendalltau

            res = compute('/home/garrick/Spring 2017/Research/qpp/data/{}/results/raw.stopped.{}'.format(col,
                                                                                                         metric_results),
                    '/home/garrick/Spring 2017/Research/qpp/out/{}/{}/{}'.format(col, pred, name),
                    cor, significance=True)
            if res[1] < 0.05:
                print(line.strip())
