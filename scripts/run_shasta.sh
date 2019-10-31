#!/bin/bash

x=$1
input=$2

time shasta --threads 32 --Align.minAlignedMarkerCount 10 --Reads.minReadLength 2500 --MarkerGraph.maxCoverage 1000000 --MarkerGraph.highCoverageThreshold 1000000 --ReadGraph.minComponentSize 10 --MinHash.minHashIterationCount 100 --MarkerGraph.pruneIterationCount 2  --input $input --assemblyDirectory $x 

# calculate coverage
time minimap2 -t 32 -ax map-ont -r2k $x/Assembly.fasta $input | sambamba view -f bam -S /dev/stdin >$x.unsrt.bam \
    && sambamba sort -o $x.bam $x.unsrt.bam \
    && rm -f $x.unsrt.bam{,.bai} \
    && samtools coverage $x.bam >$x.bam.coverage \
    && samtools depth -H -m 100000000 -a $x.bam | gzip >$x.bam.depth.tsv.gz
