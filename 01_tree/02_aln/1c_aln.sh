perl ~/scripts2/easysbatch/esbatch \
	--indir "tmp" \
	--cmd "sh /homes/liu3zhen/scripts2/easysbatch/pipelines/fungi_fq_bwa_bam.parallel.sh -m SAMtools" \
	--varPara "/homes/liu3zhen/references/fungi/magnaporthe/B71Ref2/genome/bwa/B71Ref2" \
	--inpattern ".R1.pair.fq" \
	--threads 16 \
	--mem 2 \
	--prefix 1c_aln \
	--opt4in "-f" \
	--fixPara "-c 16" \
	--opt4var "-r" \
	--submit

