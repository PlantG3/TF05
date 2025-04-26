#!/bin/sh

####################################
# initiate parameters
####################################
source 00_parameters.sh
cd $mypath
bc_check_log=$mypath/cache/01_basecall.check.log
#outdir=$mypath/cache/01_basecall
#basecall_dir=`ls -d $outdir/input/`
basecall_dir=$mypath/cache/01_basecall/input/

####################################
for edir in $basecall_dir; do
	lib/guppycheck -i $edir > $bc_check_log
	echo "##########################"
	echo "run to see the detail: more $bc_check_log"
	echo "##########################"
done

