#!/bin/bash -l
#SBATCH --mem-per-cpu=60G
#SBATCH --time=1-00:00:00
#SBATCH --cpus-per-task=1

#module load Java/1.8.0_192

# generate a bam list
vcf=xxx
ref=/homes/liu3zhen/references/fungi/magnaporthe/B71Ref2/genome/gatk/B71Ref2.fasta
out=Mo
gatk SelectVariants \
	-R $ref \
	-V $vcf \
	-select 'DP >= 400' \
	-select 'DP <= 5000' \
	--select-type-to-include SNP \
	--restrict-alleles-to BIALLELIC \
	-O ${out}.1.vcf &>${out}.1.log

# B71 matches REF
perl ~/scripts2/vcfbox/vcfbox.pl genomatch \
	-t T_B71_SRR6232156 -g 0 \
	-o ${out}.2.B71eqREF.vcf \
	${out}.1.vcf

# modify strain names
sed -i 's/_[ES]RR[0-9]*//g' Mo.2.B71eqREF.vcf
sed -i 's/-1\t/\t/g' Mo.2.B71eqREF.vcf

