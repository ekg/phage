#!/bin/bash

f=$1
b=$(dirname $f)/$(basename $f .gfa)
g=$b.gimbry

gimbricate -g $f -f $g.fa -p $g.paf -c 100 >$g.gfa
#minimap2 -c -X $g.fa $g.fa >$g.self.paf
#seqwish -s $g.fa -p $g.paf,$g.self.paf:32 -g $b.seqwish.gfa
seqwish -s $g.fa -p $g.paf -g $b.seqwish.gfa
