#!/bin/bash

in=$1
phage=$2
out=$3

minimap2 -t 32 -ax map-ont -r2k $phage $in | samtools view -h -F 4 - | samtools fastq - | pigz >$out
