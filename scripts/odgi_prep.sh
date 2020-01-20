#!/bin/bash

f=$1
b=$(dirname $f)/$(basename $f .gfa)

odgi build -g $f -o - | odgi sort -p mbn -N 64 -E 0.1 -M -i - -o $b.odgi
odgi view -i $b.odgi -g >$b.odgi.gfa
odgi viz -i $b.odgi -o $b.odgi.png -R -P 3 -x 8000 -y 400

vg view -Fv $b.odgi.gfa >$b.odgi.vg
vg index -x $b.odgi.xg $b.odgi.vg




