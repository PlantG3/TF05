#!/bin/bash
fasta=../../00_data/03_asm/TF05-1MC7/TF05-1MC7v1.fasta
perl ~/scripts/fasta/pattern.search.pl \
	-I $fasta -P "(TTAGGG|CCCTAA){5,}" -S -O F \
	| grep -e "^chr" -e "^mini" \
	> TF05-1MC7v1.telomeres.hits
cut -f 1,4,5 TF05-1MC7v1.telomeres.hits  > TF05-1MC7v1.telomeres.hits.bed

