#!/usr/bin/python

import argparse
import collections
import sys

from ir_eval import BatchSearchResults, Qrels, SearchResult, map, average_ndcg


class Clusters(object):
    def __init__(self):
        self.clusters = collections.defaultdict(dict)

    def docs_related_to(self, document):
        return self.clusters.get(document, {})

    def read(self, file):
        with open(file) as f:
            for line in f:
                parts = line.strip().split()
                orig_doc, expand_doc, score = parts[0], parts[1], float(parts[2])
                self.clusters[orig_doc][expand_doc] = score


def main():
    _map = 'map'
    _ndcg = 'ndcg'

    options = argparse.ArgumentParser(description='qpp')
    required = options.add_argument_group('required arguments')
    required.add_argument('-t', '--target-retrieval', help='target retrieval file', required=True)
    required.add_argument('-c', '--clusters', help='clusters file', required=True)
    required.add_argument('-k', '--k', type=int, help='number of target retrieval results to include', required=True)
    required.add_argument('-m', '--metric', choices=[_map, _ndcg], help='metric to use', required=True)
    options.add_argument('-q', '--query-retrieval', help='query retrieval file; same as --target-retrieval by default')
    options.add_argument('-n', '--n', type=int, help='number of clustered documents to include; same as --k by default')
    options.add_argument('-v', '--verbose', action='store_true', help='verbose output')
    args = options.parse_args()

    if args.verbose:
        def stderr(msg):
            sys.stderr.write('{}\n'.format(msg))
    else:
        def stderr(msg): pass

    if not args.query_retrieval:
        args.query_retrieval = args.target_retrieval
    if not args.n:
        args.n = args.k

    stderr('Running target {}, performance {}, with k={}'.format(args.target_retrieval, args.query_retrieval,
                                                                 str(args.k)))

    # The results of issuing the query against the "performance" index
    query_results = BatchSearchResults()
    query_results.read(args.query_retrieval)

    # The results of issuing the query on the target index; the source of the documents whose performance we care about
    target_results = BatchSearchResults()
    target_results.read(args.target_retrieval)

    # The clusters of performance index documents for each target index document
    clusters = Clusters()
    clusters.read(args.clusters)

    evaluate = average_ndcg if args.metric == _ndcg else map

    # Create pseudo-qrels based on the performance index
    pseudo_qrels = Qrels()
    for query in query_results.results:
        top_k = query_results.results[query][:args.k]
        total_score = sum([result.score for result in top_k])
        for doc in top_k:
            pseudo_qrels.qrels[query][doc.docno] = doc.score / total_score

    for query in target_results.results:
        #stderr('Processing query {}'.format(query))

        avg = 0.0
        for doc in target_results.results[query][:args.k]:
            related_docs = clusters.docs_related_to(doc.docno)
            sorted_top_n = sorted(related_docs, key=related_docs.get, reverse=True)[:args.n]

            expansion_results = BatchSearchResults()
            for expansion_doc in sorted_top_n:
                expansion_results.results[query].append(SearchResult(expansion_doc, related_docs[expansion_doc]))

            avg += evaluate(expansion_results, pseudo_qrels)

        try:
            avg /= len(target_results.results)
        except ZeroDivisionError:
            stderr('No target results. You should probably double check your inputs.')
            avg = 0.0

        print('{}\t{}'.format(query, str(avg)))


if __name__ == '__main__':
    main()
