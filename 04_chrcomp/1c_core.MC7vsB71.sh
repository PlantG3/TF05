#!/bin/bash
qry=/bulk/liu3zhen/research/projects/mini2020/main_ms/00_data/03_asm/TF05-1MC7/TF05-1MC7v1.fasta
ref=/bulk/liu3zhen/research/projects/wheatBlast2.0/10-B71Ref2/0-genome/B71Ref2.fasta
for chrnum in `seq 7`; do
	chr=chr$chrnum
	sbatch 1m_chrcomp.sh $qry $ref $chr $chr
done

# mini1 vs B71 mini
sbatch 1m_chrcomp.sh $qry $ref mini1 mini

# mini2 vs B71 mini
qry2=/bulk/liu3zhen/research/projects/mini2020/main_ms/00_data/03_asm/TF05-1MC7v1m/TF05-1MC7v1_2abbc.fasta
sbatch 1m_chrcomp.sh $qry2 $ref mini2abbc mini
qry3=/bulk/liu3zhen/research/projects/mini2020/main_ms/00_data/03_asm/TF05-1MC7v1m/TF05-1MC7v1_2abc.fasta
sbatch 1m_chrcomp.sh $qry3 $ref mini2abc mini

