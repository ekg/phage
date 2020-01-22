#!/bin/bash

f=$1
b=$(dirname $f)/$(basename $f .gfa)

odgi build -g $f -o - | odgi sort -p -p bSnSnS -t 4 -K -M -i - -o $b.odgi
odgi view -i $b.odgi -g >$b.odgi.gfa
odgi viz -i $b.odgi -o $b.odgi.png -R -P 3 -x 8000 -y 400
odgi break -i $b.odgi -o $b.break.odgi -c 100 -s 100
odgi view -i $b.break.odgi -g >$b.break.odgi.gfa

vg view -Fv $b.break.odgi.gfa >$b.vg
vg index -x $b.xg $b.vg




