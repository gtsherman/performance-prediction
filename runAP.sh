#!/bin/bash

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/AP/AP.self -q data/AP/AP.self -c res/clusters/AP/AP.clusters.self -k $k -m map -v > out/AP/pseudoScore/self/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/AP/AP.self.stopped -q data/AP/AP.self.stopped -c res/clusters/AP/AP.clusters.self -k $k -m map -v > out/AP/pseudoScore/self.stopped/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/AP/AP.self -q data/AP/AP.wiki -c res/clusters/AP/AP.clusters.wiki -k $k -m map -v > out/AP/pseudoScore/wiki/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/AP/AP.self.stopped -q data/AP/AP.wiki.stopped -c res/clusters/AP/AP.clusters.wiki -k $k -m map -v > out/AP/pseudoScore/wiki.stopped/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/AP/AP.self -q data/AP/AP.self -c res/clusters/AP/AP.clusters.self -k $k -m ndcg -v > out/AP/pseudoScore/self/${k}.ndcg
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/AP/AP.self.stopped -q data/AP/AP.self.stopped -c res/clusters/AP/AP.clusters.self -k $k -m ndcg -v > out/AP/pseudoScore/self.stopped/${k}.ndcg
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/AP/AP.self -q data/AP/AP.wiki -c res/clusters/AP/AP.clusters.wiki -k $k -m ndcg -v > out/AP/pseudoScore/wiki/${k}.ndcg
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/AP/AP.self.stopped -q data/AP/AP.wiki.stopped -c res/clusters/AP/AP.clusters.wiki -k $k -m ndcg -v > out/AP/pseudoScore/wiki.stopped/${k}.ndcg
done

# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/AP/AP.self -q data/AP/AP.self -c res/clusters/AP/AP.clusters.self -k $k -m ndcg_cut_10 -v > out/AP/pseudoScore/self/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/AP/AP.self.stopped -q data/AP/AP.self.stopped -c res/clusters/AP/AP.clusters.self -k $k -m ndcg_cut_10 -v > out/AP/pseudoScore/self.stopped/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/AP/AP.self -q data/AP/AP.wiki -c res/clusters/AP/AP.clusters.wiki -k $k -m ndcg_cut_10 -v > out/AP/pseudoScore/wiki/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/AP/AP.self.stopped -q data/AP/AP.wiki.stopped -c res/clusters/AP/AP.clusters.wiki -k $k -m ndcg_cut_10 -v > out/AP/pseudoScore/wiki.stopped/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/AP/AP.self -q data/AP/AP.self -c res/clusters/AP/AP.clusters.self -k $k -m ndcg_cut_20 -v > out/AP/pseudoScore/self/${k}.ndcg_cut_20
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/AP/AP.self.stopped -q data/AP/AP.self.stopped -c res/clusters/AP/AP.clusters.self -k $k -m ndcg_cut_20 -v > out/AP/pseudoScore/self.stopped/${k}.ndcg_cut_20
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/AP/AP.self -q data/AP/AP.wiki -c res/clusters/AP/AP.clusters.wiki -k $k -m ndcg_cut_20 -v > out/AP/pseudoScore/wiki/${k}.ndcg_cut_20
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/AP/AP.self.stopped -q data/AP/AP.wiki.stopped -c res/clusters/AP/AP.clusters.wiki -k $k -m ndcg_cut_20 -v > out/AP/pseudoScore/wiki.stopped/${k}.ndcg_cut_20
# done
