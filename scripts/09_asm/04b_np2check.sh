#!/bin/sh
####################################
# initiate
####################################
source 00_parameters.sh
cd $mypath

####################################
# nanopolish check
####################################
outdir=${mypath}/cache/04_${out}.${asm_version}.np2
splitseqDir=${outdir}/3o_split
correctDir=${outdir}/4o_correction
check_output=${outdir}/np2check.log
lib/npcor/utils/npcor_check \
	-p "$np_prefix" \
	-d "$splitseqDir" \
	-c "$correctDir" \
	-o "$check_output"

echo "- log file: "$check_output

