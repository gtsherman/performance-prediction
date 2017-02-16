#!/bin/bash

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/robust/robust.self -q data/robust/robust.self -c res/clusters/robust/robust.clusters.self -k $k -m map -v > out/robust/pseudoScore/self/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/robust/robust.self.stopped -q data/robust/robust.self.stopped -c res/clusters/robust/robust.clusters.self -k $k -m map -v > out/robust/pseudoScore/self.stopped/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/robust/robust.self -q data/robust/robust.wiki -c res/clusters/robust/robust.clusters.wiki -k $k -m map -v > out/robust/pseudoScore/wiki/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/robust/robust.self.stopped -q data/robust/robust.wiki.stopped -c res/clusters/robust/robust.clusters.wiki -k $k -m map -v > out/robust/pseudoScore/wiki.stopped/${k}.map
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/robust/robust.self -q data/robust/robust.self -c res/clusters/robust/robust.clusters.self -k $k -m ndcg -v > out/robust/pseudoScore/self/${k}.ndcg
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/robust/robust.self.stopped -q data/robust/robust.self.stopped -c res/clusters/robust/robust.clusters.self -k $k -m ndcg -v > out/robust/pseudoScore/self.stopped/${k}.ndcg
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/robust/robust.self -q data/robust/robust.wiki -c res/clusters/robust/robust.clusters.wiki -k $k -m ndcg -v > out/robust/pseudoScore/wiki/${k}.ndcg
done

for k in 1 5 10 20 50 75 100;
do
  ./src/pseudo_score.py -t data/robust/robust.self.stopped -q data/robust/robust.wiki.stopped -c res/clusters/robust/robust.clusters.wiki -k $k -m ndcg -v > out/robust/pseudoScore/wiki.stopped/${k}.ndcg
done

# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/robust/robust.self -q data/robust/robust.self -c res/clusters/robust/robust.clusters.self -k $k -m ndcg_cut_10 -v > out/robust/pseudoScore/self/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/robust/robust.self.stopped -q data/robust/robust.self.stopped -c res/clusters/robust/robust.clusters.self -k $k -m ndcg_cut_10 -v > out/robust/pseudoScore/self.stopped/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/robust/robust.self -q data/robust/robust.wiki -c res/clusters/robust/robust.clusters.wiki -k $k -m ndcg_cut_10 -v > out/robust/pseudoScore/wiki/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/robust/robust.self.stopped -q data/robust/robust.wiki.stopped -c res/clusters/robust/robust.clusters.wiki -k $k -m ndcg_cut_10 -v > out/robust/pseudoScore/wiki.stopped/${k}.ndcg_cut_10
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/robust/robust.self -q data/robust/robust.self -c res/clusters/robust/robust.clusters.self -k $k -m ndcg_cut_20 -v > out/robust/pseudoScore/self/${k}.ndcg_cut_20
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/robust/robust.self.stopped -q data/robust/robust.self.stopped -c res/clusters/robust/robust.clusters.self -k $k -m ndcg_cut_20 -v > out/robust/pseudoScore/self.stopped/${k}.ndcg_cut_20
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/robust/robust.self -q data/robust/robust.wiki -c res/clusters/robust/robust.clusters.wiki -k $k -m ndcg_cut_20 -v > out/robust/pseudoScore/wiki/${k}.ndcg_cut_20
# done
# 
# for k in 1 5 10 20 50 75 100;
# do
#   ./src/pseudo_score.py -t data/robust/robust.self.stopped -q data/robust/robust.wiki.stopped -c res/clusters/robust/robust.clusters.wiki -k $k -m ndcg_cut_20 -v > out/robust/pseudoScore/wiki.stopped/${k}.ndcg_cut_20
# done
