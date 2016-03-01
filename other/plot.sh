#!/bin/bash

PHASE=`expr 45 \* $1`

gnuplot << EOF > plot$1.svg
set isosamples 16
set samples 16
set angles degrees
unset key
unset clip
set linetype 1 lc rgb "white" lw 1 pt 1
set title "J_0(r^2)"
set xrange [-4:4]
set yrange [-4:4]
set zrange [-2:2]
set hidden3d
splot 1*cos(20*(x**2+y**2)+$PHASE)*(5/(x**2+y**2+3)) with dots lt 1
set view 29,53
set term svg size 320,200 background rgb "black"
set out plot$1.svg
replot
EOF
