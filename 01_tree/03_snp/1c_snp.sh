#!/bin/bash
bamdir=0_bam
ref=/homes/liu3zhen/references/fungi/magnaporthe/B71Ref2/genome/gatk/B71Ref2.fasta
perl ~/local/slurm/snp/gatk.sbatch.pl \
	--outbase 1o \
	--bampaths $bamdir \
	--otherpara "--sample-ploidy 1" \
	--ref $ref \
	--mem 12G --time "0-12:00:00" --maxlen 200000
  #--checkscript
