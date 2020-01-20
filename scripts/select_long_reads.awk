#!/usr/bin/awk -f

BEGIN {
    FS = "\t"
    OFS = "\n"
    MINLENGTH = ARGV[ARGC-1]
    ARGC--
}

{
    header = $0
    getline seq
    getline qheader
    getline qseq
    if (length(seq) >= MINLENGTH) {
	print header, seq, qheader, qseq
    }
}

