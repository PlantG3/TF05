#!/bin/bash
#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-00:00:00

if [ ! -z $SLURM_CPUS_PER_TASK ]; then
	ncpu=$SLURM_CPUS_PER_TASK
else
	ncpu=4
fi

data=../1a_dataGL
ref=/bulk/guifanglin/1-projects/2-wheatblast/1-TF05-1/1-asm/results/2r-polished/1ac_TF051mc7sp1np2020/1ac_TF051mc7sp1np2020.v0.222.fasta
sfq=$data/TF05-1_MC7SP1.gp422.fq
qfq=$data/TF05-1_MC7202.gp422.fq
binbed=../01_MC7212/1o_MC7212-Mc7_1c_bin.bed
perl /homes/liu3zhen/scripts2/CGRD/cgrdlong \
	--ref $ref \
	--subj MC7ori --sfq $sfq \
	--qry MC7202 --qfq $qfq \
	--prefix 1o_MC7202-Mc7 \
	--splitreadlen 10000 \
	--minreadlen 10000 \
	--knum 10000 \
	--binbed $binbed \
	--groupval "-0.6 -0.5 0.5 0.6" \
	--threads $ncpu

