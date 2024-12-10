#!/bin/sh
####################################
# initiate
####################################
source 00_parameters.sh
cd $mypath

####################################
# nanopolish check
####################################
outdir=${mypath}/cache/03_${out}.${asm_version}.np
splitseqDir=${outdir}/3o_split
#np_prefix=np # this was defined in 00_parameters.sh
correctDir=${outdir}/4o_correction
check_output=${outdir}/npcheck.log
lib/npcor/utils/npcor_check \
	-p "$np_prefix" \
	-d "$splitseqDir" \
	-c "$correctDir" \
	-o "$check_output"

echo "- log file: "$check_output

