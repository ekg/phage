#!/usr/bin/awk -f

BEGIN {
    FS = "\t"
    OFS = "\n"
}

{
    header = $0
    getline seq
    getline qheader
    getline qseq
    print length(seq)
}

