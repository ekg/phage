#!/bin/bash

f=$1
b=$(dirname $f)/$(basename $f .gfa)

odgi build -g $f -o - | odgi sort -p bSnSnS -t 4 -K -M -i - -o $b.odgi
odgi view -i $b.odgi -g >$b.odgi.gfa
odgi viz -i $b.odgi -o $b.odgi.png -P 3 -x 8000 -y 400
odgi viz -i $b.odgi -o $b.odgi.R.png -R -P 3 -x 8000 -y 400
odgi break -i $b.odgi -o - -c 1000 -s 1000 \
    | odgi break -i $b.odgi -o - -c 1000 -s 1000 \
    | odgi break -i $b.odgi -o - -c 1000 -s 1000 \
    | odgi break -i $b.odgi -o - -c 1000 -s 1000 >$b.break.odgi
odgi view -i $b.break.odgi -g >$b.break.odgi.gfa

vg view -Fv $b.break.odgi.gfa >$b.break.odgi.vg
vg index -x $b.break.odgi.xg $b.break.odgi.vg




