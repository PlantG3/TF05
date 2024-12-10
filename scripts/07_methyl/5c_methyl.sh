#!/bin/bash
#SBATCH --mem-per-cpu=2G
#SBATCH --time=3-00:00:00
#SBATCH --cpus-per-task=16
methl=/homes/liu3zhen/software/Bismark/Bismark_v0.22.1_dev/bismark_methylation_extractor
ref=../1_genomePrep
dedupDir=../3_aln
ncpus=$SLURM_CPUS_PER_TASK
#module load SAMtools/1.9-foss-2018b
module load SAMtools

for bam in $dedupDir/*deduplicated.bam; do
  $methl -p --no_overlap --comprehensive \
  --cytosine_report --genome_folder $ref \
  -bedGraph --scaffolds --gzip --parallel $ncpus \
  --buffer_size 10G \
  $bam
done

