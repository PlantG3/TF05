#!/bin/bash
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00

#module load SAMtools/1.9-foss-2018b
module load SAMtools
ncpus=$SLURM_CPUS_PER_TASK;
bismark=/homes/liu3zhen/software/Bismark/Bismark_v0.22.1_dev/bismark
refdir=/bulk/liu3zhen/research/projects/mini2020/main_sl/1_TF05-1/5_TF05-1methyl/1_genomePrep
fq1=$1
fq2=$2
$bismark --bowtie2 \
		-p $ncpus $refdir \
		--1 $fq1 --2 $fq2

