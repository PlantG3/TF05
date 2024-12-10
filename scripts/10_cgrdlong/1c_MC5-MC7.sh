#!/bin/bash
#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-00:00:00

. "/homes/liu3zhen/anaconda3/etc/profile.d/conda.sh"
export PATH="/homes/liu3zhen/anaconda3/bin:$PATH"
conda activate cgrd

if [ ! -z $SLURM_CPUS_PER_TASK ]; then
	ncpu=$SLURM_CPUS_PER_TASK
else
	ncpu=4
fi

data=../../00_data/02_Nanopore
#TF05-1MC5.fastq
ref=../../00_data/03_asm/TF05-1MC7/TF05-1MC7v1.fasta
sfq=$data/TF05-1MC7.fastq
qfq=$data/TF05-1MC5.fastq
#binbed=../00_binbed/MC7.k10000.bin.bed
perl /homes/liu3zhen/scripts2/CGRD/cgrdlong \
	--ref $ref \
	--subj MC7 --sfq $sfq \
	--qry MC5 --qfq $qfq \
	--prefix ONT_MC5-MC7 \
	--splitreadlen 10000 \
	--minreadlen 10000 \
	--knum 10000 \
	--groupval "-0.8 -0.5 0.5 0.8" \
	--threads $ncpu

#/bulk/liu3zhen/research/projects/mini2020/main_ms/11_cgrdlong/01_MC5
