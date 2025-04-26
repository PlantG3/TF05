#!/bin/bash
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
module load SAMtools
dedup=/homes/liu3zhen/software/Bismark/Bismark_v0.22.1_dev/deduplicate_bismark
for bam in *_bt2_pe.bam; do
	echo $bam
	$dedup -p --bam $bam
done


