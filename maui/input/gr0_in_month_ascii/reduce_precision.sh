#!/bin/sh
for fname in `ls *.txt`

do

  new_fname=$(echo $fname | sed "s/txt/asc/g")
  gdal_translate -ot Float32 -of AAIGrid -a_nodata -9999.0 -co "DECIMAL_PRECISION=3" $fname $new_fname

done