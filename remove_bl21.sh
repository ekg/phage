#!/bin/bash

in=$1
out=$2

minimap2 -t 32 -ax map-ont -r2k ../refs/E_coli_bl21_DE3_polished.fasta $in | samtools view -h -f 4 - | samtools fastq - | pigz >$out
