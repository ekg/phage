#!/bin/bash

in=$1
out=$2
gsize=$3
threads=32

# build the assembly

wtdbg2 -g $gsize -i $in -t $threads -p 0 -k 15 -AS 1 -s 0.05 -L 500 -K 10000 -fo $out
wtpoa-cns -t $threads -i $out.ctg.lay.gz -fo $out.raw.fa
minimap2 -t $threads -ax map-ont -r2k $out.raw.fa $in | sambamba view -f bam -S /dev/stdin >$out.raw.bam
sambamba sort -o $out.bam $out.raw.bam
rm -f $out.raw.bam{,.bai}
samtools view -F0x900 $out.bam | wtpoa-cns -t $threads -d $out.raw.fa -i - -fo $out.cns.fa
rm -f $out.bam{,.bai}

# map the reads back to it

minimap2 -t $threads -ax map-ont -r2k $out.cns.fa $in  | sambamba view -f bam -S /dev/stdin >$out.unsrt.bam
sambamba sort -o $out.bam $out.unsrt.bam
rm -f $out.unsrt.bam{,.bai}

# figure out the coverage distribution

samtools coverage $out.bam >$out.bam.coverage
