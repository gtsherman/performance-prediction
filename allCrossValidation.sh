#!/bin/bash

for t in AP robust wt10g; do echo $t; for c in self.stopped wiki.stopped; do echo $c; for m in `ls out/$t/pseudoScore/$c`; do echo $m; r=$m; if [ $m == "ndcg" ]; then r="ndcg_cut_20"; fi; echo "./src/scripts/runValidation.py -j data/$t/results/raw.stopped.$r -d out/$t/pseudoScore/$c/$m -r 1"; ./src/scripts/runValidation.py -j data/$t/results/raw.stopped.$r -d out/$t/pseudoScore/$c/$m -r 1 -c kendall > crossValidated/pseudo/$t/$c/$m.k10.r1.kendall; done; done; done
