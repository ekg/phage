#!/bin/bash

f=$1
b=$(dirname $f)/$(basename $f .gfa)
g=$b.gimbry

gimbricate -g $f -f $g.fa -p $g.paf >$g.gfa
minimap2 -c -X $g.fa $g.fa >$g.self.paf
cat $g.paf $g.self.paf >$g.all.paf
seqwish -s $g.fa -p $g.all.paf -g $b.seqwish.gfa
