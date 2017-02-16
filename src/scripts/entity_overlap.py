#!/usr/bin/python

from __future__ import division
from sys import argv


def main(out_file, clusters_file, topk_docs, topk_entities):
	returned, all_returned = read_out_file(out_file, topk_docs)
	clusters = read_clusters_file(clusters_file, all_returned, topk_entities)

	for query in returned:
		doc_ent_sets = []
		for doc in returned[query]:
			if doc in clusters:
				doc_ent_sets.append(clusters[doc])
		print('{}\t{}'.format(query, str(average_jaccard(*doc_ent_sets))))


def read_out_file(out_file, topk):
	returned = {}
	all_returned = set()
	with open(out_file) as f:
		for line in f:
			query, _, doc, rank, score, _ = line.split()
			returned[query] = set() if query not in returned else returned[query]
			if int(rank) <= topk:
				returned[query].add(doc)
				all_returned.add(doc)

	return (returned, all_returned)

def read_clusters_file(clusters_file, all_returned, topk):
	clusters = {}
	with open(clusters_file) as f:
		cur_doc = None
		cur_ent = 0
		for line in f:
			doc, entity, score = line.split()
			if doc != cur_doc:
				cur_doc = doc
				cur_ent = 1
			elif cur_ent > topk:
				continue
			if doc in all_returned:
				cur_ent += 1
				clusters[doc] = set() if doc not in clusters else clusters[doc]
				clusters[doc].add(entity)
	return clusters

def jaccard(s1, s2):
	return len(set.intersection(s1, s2)) / len(set.union(s1, s2))

def average_jaccard(*sets):
	jacc = 0
	for i in range(len(sets)):
		for j in range(i+1, len(sets)):
			jacc += jaccard(sets[i], sets[j])
	return jacc / (len(sets)*(len(sets)-1)/2)

if __name__ == '__main__':
	out_file = argv[1]
	clusters_file = argv[2]
	topk_docs = int(argv[3])
	topk_entities = int(argv[4])

	main(out_file, clusters_file, topk_docs, topk_entities)
