#!/usr/bin/python

import argparse


def read_out_file(path, limit=float('inf')):
	qdocs = {}
	with open(path) as f:
		for line in f:
			q, _, doc, rank, _, _ = line.split()
			if int(rank) <= limit:
				if q not in qdocs:
					qdocs[q] = set()
				qdocs[q].add(doc)
	return qdocs

def read_score_file(path, delimiter='\t', doc_col=1, score_col=0):
	docscores = {}
	with open(path) as f:
		for line in f:
			parts = line.split(delimiter)
			doc = parts[doc_col-1]
			score = float(parts[score_col-1])
			docscores[doc] = score
	return docscores

if __name__ == '__main__':
	options = argparse.ArgumentParser('Get average scores')
	options.add_argument('outfile', help='the retrieval out-file to identify documents whose scores should be averaged')
	options.add_argument('scorefile', help='the file listing the scores of each document')
	options.add_argument('-n', '--out-file-limit', type=int, default=float('inf'), help='number of out docs to average over per query')
	options.add_argument('-d', '--delimiter', type=str, default='\t', help='column delimiter of the score file')
	options.add_argument('-c', '--document-column', type=int, default=1, help='the column of the score file representing the document')
	options.add_argument('-s', '--score-column', type=int, default=0, help='the column of the score file representing the score')
	args = options.parse_args()

	
	docscores = read_score_file(args.scorefile, delimiter=args.delimiter, doc_col=args.document_column, score_col=args.score_column)
	qdocs = read_out_file(args.outfile, args.out_file_limit)

	for query in qdocs:
		docs = qdocs[query]
		total = 0
		for doc in docs:
			if doc not in docscores:
				docs.remove(doc)
				continue
			total += docscores[doc]
		avg = total / len(docs)
		print('{}\t{}'.format(query, str(avg)))
