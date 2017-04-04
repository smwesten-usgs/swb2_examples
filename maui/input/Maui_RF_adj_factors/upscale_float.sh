#!/bin/sh

fname=$1

new_fname=$(echo $fname | sed "s/.asc//g")__50m.asc
gdal_translate -ot Float32 -tr 50 50 -of AAIGrid -a_nodata -99.  -co "DECIMAL_PRECISION=3" $fname $new_fname
