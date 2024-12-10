#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=1-00:00:00

genomeprep=/homes/liu3zhen/software/Bismark/Bismark_v0.22.1_dev/bismark_genome_preparation
#/homes/jinguanglin/software/Bismark_v0.20.0/bismark_genome_preparation
refdir=.
$genomeprep $refdir --bowtie2

