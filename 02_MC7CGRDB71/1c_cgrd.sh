#!/bin/bash
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=3G
#SBATCH --time=0-23:00:00
#SBATCH --partition=ksu-biol-ari.q,ksu-plantpath-liu3zhen.q,batch.q
sfq1=/bulk/liu3zhen/research/projects/wheatBlast2.0/00-B71v1/00-Illumina/B71.R1.pair.fq
sfq2=/bulk/liu3zhen/research/projects/wheatBlast2.0/00-B71v1/00-Illumina/B71.R2.pair.fq
qfq1=/bulk/liu3zhen/research/projects/TF05-1/3-Illumina/1-trim/MC7-2-wg_S5_L001.R1.pair.fq
qfq2=/bulk/liu3zhen/research/projects/TF05-1/3-Illumina/1-trim/MC7-2-wg_S5_L001.R2.pair.fq
ref=/homes/liu3zhen/references/magnaporthe/MoT_B71/B71Ref2/genome/B71Ref2.fasta
perl ~/scripts2/CGRD/cgrd --ref $ref \
	--subj B71 --sfq1 $sfq1 --sfq2 $sfq2 \
	--qry TF05-1MC7 -qfq1 $qfq1 -qfq2 $qfq2 \
	--prefix MC7 --threads 16

