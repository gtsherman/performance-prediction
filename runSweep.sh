#!/bin/bash
# $1 = collection

# self
# map
for n in 1 5 10 20 50 75 100
do
  for k in 1 5 10 20 50 75 100
  do
    for p in 1 5 10 20 50 75 100
    do
      if [ $p -le $n ]
      then
        ./src/scripts/pseudo_score.py -t data/$1/$1.self.stopped -c res/clusters/$1/$1.clusters.self -q data/$1/$1.self.stopped -n $n -k $k -p $p -m map > "out/$1/pseudoScore/self.stopped/map/n$n.k$k.p$p"
      fi;
    done
  done
done &

# self
# ndcg
for n in 1 5 10 20 50 75 100
do
  for k in 1 5 10 20 50 75 100
  do
    for p in 1 5 10 20 50 75 100
    do
      if [ $p -le $n ]
      then
      ./src/scripts/pseudo_score.py -t data/$1/$1.self.stopped -c res/clusters/$1/$1.clusters.self -q data/$1/$1.self.stopped -n $n -k $k -p $p -m ndcg > "out/$1/pseudoScore/self.stopped/ndcg/n$n.k$k.p$p"
      fi;
    done
  done
done &

# wiki
# map
for n in 1 5 10 20 50 75 100
do
  for k in 1 5 10 20 50 75 100
  do
    for p in 1 5 10 20 50 75 100
    do
      if [ $p -le $n ]
      then
      ./src/scripts/pseudo_score.py -t data/$1/$1.self.stopped -c res/clusters/$1/$1.clusters.wiki -q data/$1/$1.wiki.stopped -n $n -k $k -p $p -m map > "out/$1/pseudoScore/wiki.stopped/map/n$n.k$k.p$p"
      fi;
    done
  done
done &

# wiki
# ndcg
for n in 1 5 10 20 50 75 100
do
  for k in 1 5 10 20 50 75 100
  do
    for p in 1 5 10 20 50 75 100
    do
      if [ $p -le $n ]
      then
        ./src/scripts/pseudo_score.py -t data/$1/$1.self.stopped -c res/clusters/$1/$1.clusters.wiki -q data/$1/$1.wiki.stopped -n $n -k $k -p $p -m ndcg > "out/$1/pseudoScore/wiki.stopped/ndcg/n$n.k$k.p$p"
      fi;
    done
  done
done &

wait
