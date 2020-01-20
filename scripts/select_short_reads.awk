#!/usr/bin/awk -f

BEGIN {
    FS = "\t"
    OFS = "\n"
    MAXLENGTH = ARGV[ARGC-1]
    ARGC--
}

{
    header = $0
    getline seq
    getline qheader
    getline qseq
    if (length(seq) <= MAXLENGTH) {
	print header, seq, qheader, qseq
    }
}

