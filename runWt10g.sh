#!/bin/bash

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/wt10g/wt10g.self -q data/wt10g/wt10g.self -c res/clusters/wt10g/wt10g.clusters.self -k $k -m map -v > out/wt10g/pseudoScore/self/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/wt10g/wt10g.self.stopped -q data/wt10g/wt10g.self.stopped -c res/clusters/wt10g/wt10g.clusters.self -k $k -m map -v > out/wt10g/pseudoScore/self.stopped/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/wt10g/wt10g.self -q data/wt10g/wt10g.wiki -c res/clusters/wt10g/wt10g.clusters.wiki -k $k -m map -v > out/wt10g/pseudoScore/wiki/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/wt10g/wt10g.self.stopped -q data/wt10g/wt10g.wiki.stopped -c res/clusters/wt10g/wt10g.clusters.wiki -k $k -m map -v > out/wt10g/pseudoScore/wiki.stopped/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/wt10g/wt10g.self -q data/wt10g/wt10g.self -c res/clusters/wt10g/wt10g.clusters.self -k $k -m ndcg -v > out/wt10g/pseudoScore/self/${k}.ndcg
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/wt10g/wt10g.self.stopped -q data/wt10g/wt10g.self.stopped -c res/clusters/wt10g/wt10g.clusters.self -k $k -m ndcg -v > out/wt10g/pseudoScore/self.stopped/${k}.ndcg
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/wt10g/wt10g.self -q data/wt10g/wt10g.wiki -c res/clusters/wt10g/wt10g.clusters.wiki -k $k -m ndcg -v > out/wt10g/pseudoScore/wiki/${k}.ndcg
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/wt10g/wt10g.self.stopped -q data/wt10g/wt10g.wiki.stopped -c res/clusters/wt10g/wt10g.clusters.wiki -k $k -m ndcg -v > out/wt10g/pseudoScore/wiki.stopped/${k}.ndcg
done

# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/wt10g/wt10g.self -q data/wt10g/wt10g.self -c res/clusters/wt10g/wt10g.clusters.self -k $k -m ndcg_cut_10 -v > out/wt10g/pseudoScore/self/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/wt10g/wt10g.self.stopped -q data/wt10g/wt10g.self.stopped -c res/clusters/wt10g/wt10g.clusters.self -k $k -m ndcg_cut_10 -v > out/wt10g/pseudoScore/self.stopped/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/wt10g/wt10g.self -q data/wt10g/wt10g.wiki -c res/clusters/wt10g/wt10g.clusters.wiki -k $k -m ndcg_cut_10 -v > out/wt10g/pseudoScore/wiki/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/wt10g/wt10g.self.stopped -q data/wt10g/wt10g.wiki.stopped -c res/clusters/wt10g/wt10g.clusters.wiki -k $k -m ndcg_cut_10 -v > out/wt10g/pseudoScore/wiki.stopped/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/wt10g/wt10g.self -q data/wt10g/wt10g.self -c res/clusters/wt10g/wt10g.clusters.self -k $k -m ndcg_cut_20 -v > out/wt10g/pseudoScore/self/${k}.ndcg_cut_20
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/wt10g/wt10g.self.stopped -q data/wt10g/wt10g.self.stopped -c res/clusters/wt10g/wt10g.clusters.self -k $k -m ndcg_cut_20 -v > out/wt10g/pseudoScore/self.stopped/${k}.ndcg_cut_20
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/wt10g/wt10g.self -q data/wt10g/wt10g.wiki -c res/clusters/wt10g/wt10g.clusters.wiki -k $k -m ndcg_cut_20 -v > out/wt10g/pseudoScore/wiki/${k}.ndcg_cut_20
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/wt10g/wt10g.self.stopped -q data/wt10g/wt10g.wiki.stopped -c res/clusters/wt10g/wt10g.clusters.wiki -k $k -m ndcg_cut_20 -v > out/wt10g/pseudoScore/wiki.stopped/${k}.ndcg_cut_20
# done
