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
      echo $n $k $p
      ./src/scripts/pseudo_score.py -t data/$1/$1.self.stopped -c res/clusters/$1/$1.clusters.wiki -q data/$1/$1.wiki.stopped -n $n -k $k -p $p -m map > "tmp/n$n.k$k.p$p"
      fi;
    done
  done
done
