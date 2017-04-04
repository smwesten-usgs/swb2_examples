#!/bin/sh
for fname in `ls *.asc`

do

  new_fname=$(echo $fname | sed "s/.asc//g")_maui.asc
  gdal_translate -ot Float32 -of AAIGrid -a_nodata -99. -projwin_srs "+proj=longlat +datum=WGS84 +no_defs" -projwin -156.7 21.06 -155.9 20.53 -co "DECIMAL_PRECISION=2" $fname $new_fname

done
