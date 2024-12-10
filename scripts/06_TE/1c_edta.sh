#!/bin/bash -l
#SBATCH --cpus-per-task=96
#SBATCH --mem-per-cpu=1G
#SBATCH --time=6-00:00:00
##SBATCH --partition=ksu-gen-highmem.q,batch.q,ksu-biol-ari.q,ksu-plantpath-liu3zhen.q
#module load foss
#conda activate edta
conda activate EDTA
genome=TF05-1MC7Ref1.fasta
EDTA.pl \
	--genome $genome \
	-sensitive 1 \
	--anno 1 \
	--evaluate 1 \
	--threads 96

