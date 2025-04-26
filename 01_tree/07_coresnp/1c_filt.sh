#!/bin/bash
ori=../03_snp/Mo.2.B71eqREF.vcf
in=Mo.1.core.B71eqREF.vcf
prefix=Mo.1.core

grep -e "^#" -e "^chr" $ori > $in
vcftools --vcf $in --maf 0.1 --max-missing 0.2 --recode --out $prefix
/homes/liu3zhen/software/vcf2phylip/vcf2phylip.py -i ${prefix}.recode.vcf -f -m 10

