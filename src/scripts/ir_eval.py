#!/usr/bin/python

import argparse
import collections
import math


class Qrels(object):
    def __init__(self):
        self.qrels = collections.defaultdict(dict)

    def relevance(self, query, document):
        return (self.qrels[query][document]
                if query in self.qrels and document in self.qrels[query] else 0)

    def relevant(self, query, document):
        return self.relevance(query, document) > 0

    def num_relevant(self, query):
        return len(self.qrels[query])

    def read(self, file):
        with open(file) as f:
            for line in f:
                parts = line.split()
                query, document, score = parts[0], parts[2], parts[3]
                if float(score) > 0:
                    self.qrels[query][document] = score


class SearchResult(object):
    def __init__(self, docno, score):
        self.docno = docno
        self.score = score


class BatchSearchResults(object):
    def __init__(self):
        self.results = collections.defaultdict(list)

    def read(self, file):
        with open(file) as f:
            for line in f:
                parts = line.split()
                query, document, score = parts[0], parts[2], float(parts[4])
                self.results[query].append(SearchResult(document, score))

"""MAP"""


def average_precision(query, search_results, qrels):
    ap = 0.0
    rels = 0

    for i, search_result in enumerate(search_results):
        if qrels.relevant(query, search_result.docno):
            rels += 1
            ap += rels / float(i+1)

    try:
        ap /= qrels.num_relevant(query)
    except ZeroDivisionError:
        ap = 0.0

    return ap


def mean_average_precision(batch_search_results, qrels):
    map = 0.0

    for query in batch_search_results.results:
        map += average_precision(query, batch_search_results.results[query], qrels)

    map /= len(batch_search_results.results)

    return map


# Easier name
map = mean_average_precision


"""nDCG"""

def _dcg_at_rank(relevance, rank):
    return


def discounted_cumulative_gain(query, search_results, qrels, rank_cutoff=20):
    dcg = 0.0
    for i, search_result in enumerate(search_results[:rank_cutoff]):
        dcg += (math.pow(2, float(qrels.relevance(query, search_result.docno)))-1) / math.log(float(i)+2)
    return dcg


# Easier name
dcg = discounted_cumulative_gain


def ideal_discounted_cumulative_gain(query, qrels, rank_cutoff=20):
    rels = qrels.qrels.get(query, {})
    docs_in_order = sorted(rels, key=rels.get, reverse=True)
    ideal_results = [SearchResult(doc, i) for i, doc in enumerate(docs_in_order)]
    return discounted_cumulative_gain(query, ideal_results, qrels, rank_cutoff)


# Easier name
idcg = ideal_discounted_cumulative_gain


def normalized_discounted_cumulative_gain(query, search_results, qrels, rank_cutoff=20):
    dcg = discounted_cumulative_gain(query, search_results, qrels, rank_cutoff)
    idcg = ideal_discounted_cumulative_gain(query, qrels, rank_cutoff)
    if idcg == 0:
        return 0
    return dcg / idcg


# Easier name
ndcg = normalized_discounted_cumulative_gain


def average_normalized_discounted_cumulative_gain(batch_search_results, qrels, rank_cutoff=20):
    avg = 0.0
    for query in batch_search_results.results:
        avg += normalized_discounted_cumulative_gain(query, batch_search_results.results[query], qrels, rank_cutoff)
    avg /= len(batch_search_results.results)
    return avg


# Easier name
average_ndcg = average_normalized_discounted_cumulative_gain


def main():
    _map = 'map'
    _ndcg = 'ndcg'

    options = argparse.ArgumentParser(description='Evaluate search results')
    required = options.add_argument_group('required arguments')
    required.add_argument('-q', '--qrels', help='qrels file', required=True)
    required.add_argument('-r', '--results', help='search results file', required=True)
    required.add_argument('-m', '--metric', choices=[_map, _ndcg], help='evaluation metric', required=True)
    options.add_argument('-t', '--topic', help='specific topic to evaluate')
    options.add_argument('-c', '--cutoff', type=int, help='rank cutoff, for use with certain metrics')
    args = options.parse_args()

    qrels = Qrels()
    qrels.read(args.qrels)

    results = BatchSearchResults()
    results.read(args.results)

    cutoff = args.cutoff if args.cutoff else 20

    if args.topic:
        if args.topic not in results.results:
            print('Topic {} not present in results'.format(args.topic))
            exit()
        if args.metric == _map:
            print('Average precision: {}'.format(str(average_precision(args.topic, results.results[args.topic],
                                                                       qrels))))
        elif args.metric == _ndcg:
            print('nDCG@{}: {}'.format(str(cutoff), str(normalized_discounted_cumulative_gain(args.topic,
                results.results[args.topic], qrels, cutoff))))
    else:
        if args.metric == _map:
            print('Mean average precision: {}'.format(str(mean_average_precision(results, qrels))))
        elif args.metric == _ndcg:
            print('Average nDCG@{}: {}'.format(str(cutoff), str(average_normalized_discounted_cumulative_gain(
                results, qrels, cutoff))))

if __name__ == '__main__':
    main()

