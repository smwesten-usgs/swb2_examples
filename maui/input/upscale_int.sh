#!/bin/sh

fname=$1

new_fname=$(echo $fname | sed "s/10m.asc//g")50m.asc
gdal_translate -ot Int32 -tr 50 50 -of AAIGrid -a_nodata -9999 $fname $new_fname
