#!/bin/bash

x=$1
input=$2
threads=$3
simplify=$4
readlength=$5
hashiteration=$6

time shasta --threads $threads \
    --Align.minAlignedMarkerCount 10 \
    --Reads.minReadLength $readlength \
    --Kmers.k 10 \
    --Kmers.probability 0.1 \
    --MinHash.maxBucketSize 100 \
    --MarkerGraph.minCoverage 100 \
    --MarkerGraph.maxCoverage 10000000 \
    --MarkerGraph.lowCoverageThreshold 10 \
    --MarkerGraph.highCoverageThreshold 100 \
    --MarkerGraph.edgeMarkerSkipThreshold 100 \
    --ReadGraph.maxAlignmentCount 6 \
    --ReadGraph.minComponentSize 10 \
    --MinHash.minHashIterationCount $hashiteration \
    --MarkerGraph.pruneIterationCount 6 \
    --MarkerGraph.simplifyMaxLength $simplify \
    --input $input \
    --assemblyDirectory $x

#--memoryMode filesystem --memoryBacking 2M \
#shasta --command cleanupBinaryData

# calculate coverage
#time minimap2 -t 32 -ax map-ont -r2k $x/Assembly.fasta $input \
#    | sambamba view -f bam -S /dev/stdin >$x.unsrt.bam \
#    && sambamba sort -o $x.bam $x.unsrt.bam \
#    && rm -f $x.unsrt.bam{,.bai} \
#    && samtools coverage $x.bam >$x.bam.coverage \
#    && samtools depth -H -m 100000000 -a $x.bam | gzip >$x.bam.depth.tsv.gz
