#!/bin/bash
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=2g
#SBATCH --time=0-03:00:00
fasta=../03_snp/Mo.3.recode.min10.fasta
in=Mo.3.fasta
ln -s $fasta $in
#model=GTR+F+ASC+R2
# model test
#/homes/liu3zhen/software/iqtree/iqtree-1.6.12-Linux/bin/iqtree \
#	-s $in -m $model -bb 1000 -nt 24 -redo
# iqtree2
/homes/liu3zhen/software/iqtree2/iqtree-2.2.0-Linux/bin/iqtree2 \
	-s $in -bb 10000 -m MFP -nt 24 -redo

