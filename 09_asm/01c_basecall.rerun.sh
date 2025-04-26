#!/bin/sh

####################################
# initiate parameters
####################################
source 00_parameters.sh
cd $mypath

####################################
# input folder 
####################################
# create a output folder
outdir=cache/01_basecall

####################################
# base call using cpu
####################################
guppy_script=lib/cpuGuppy
$guppy_script \
	-d input \
	-o $outdir\
    -c $guppy_model \
    -n $basecall_narray \
    -u $basecall_cpus \
	-r

