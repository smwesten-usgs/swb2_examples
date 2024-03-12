rmdir /s /q output
rmdir /s /q logfiles
mkdir output
mkdir logfiles

..\bin\swb2 --output_prefix=central_sands_ --logfile_dir=logfiles --output_dir=output central_sands_swb2_daymet4.ctl
