#!/bin/bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=4G
#SBATCH --time=3-00:00:00
#module load R
. "/homes/liu3zhen/anaconda3/etc/profile.d/conda.sh"
export PATH="/homes/liu3zhen/anaconda3/bin:$PATH"
conda activate syri2

ncpu=$SLURM_CPUS_PER_TASK

qry=$1
ref=$2
qchr=$3
rchr=$4
echo $chr
qryname=`basename $qry | sed 's/.fasta$//; s/.fas$//; s/.fa$//'`
refname=`basename $ref | sed 's/.fasta$//; s/.fas$//; s/.fa$//'`
echo $qryname
echo $refname
perl ~/scripts2/chrcomp/chrcomp \
	--prefix ${qryname}"_"${refname} \
	--qry $qry --qchr $qchr --qryname $qryname \
	--ref $ref --rchr $rchr --refname $refname \
	--threads $ncpu --match 10000 --identity 90 \
	--nuc4para "--maxmatch --breaklen 500 --mincluster 500 --minmatch 45" \
	--syriOption "--invgaplen 50000 --allow-offset 100" \
	--maxinvsegratio 1.5 --minsyn 10000 --minhdr 1000000 --minothers 50000

