#!/bin/bash

in=$1
ref=$2
out=$3

minimap2 -t 32 -ax map-ont -r2k $ref $in | samtools view -h -f 4 - | samtools fastq - | pigz >$out
