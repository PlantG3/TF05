#!/bin/bash

# CG
gunzip -c ../../../main_sl/01_TF05-1/5_TF05-1methyl/4_methyl/TF0511_bt2_pe.deduplicated.bismark.cov.gz | bedtools intersect -a - -b 1i_MC7.LTR.bed > MC1.CG.LTR.bismark.cov
gunzip -c ../../../main_sl/01_TF05-1/5_TF05-1methyl/4_methyl/TF0517_bt2_pe.deduplicated.bismark.cov.gz | bedtools intersect -a - -b 1i_MC7.LTR.bed > MC7.CG.LTR.bismark.cov

# CHG
gunzip -c ../../../main_sl/01_TF05-1/5_TF05-1methyl/5_methyl_CHH-CHG/CHG_context_TF0511.cov.gz.bismark.cov.gz | bedtools intersect -a - -b 1i_MC7.LTR.bed > MC1.CHG.LTR.bismark.cov
gunzip -c ../../../main_sl/01_TF05-1/5_TF05-1methyl/5_methyl_CHH-CHG/CHG_context_TF0517.cov.gz.bismark.cov.gz | bedtools intersect -a - -b 1i_MC7.LTR.bed > MC7.CHG.LTR.bismark.cov

# CHH
gunzip -c ../../../main_sl/01_TF05-1/5_TF05-1methyl/5_methyl_CHH-CHG/CHH_context_TF0511.cov.gz.bismark.cov.gz | bedtools intersect -a - -b 1i_MC7.LTR.bed > MC1.CHH.LTR.bismark.cov
gunzip -c ../../../main_sl/01_TF05-1/5_TF05-1methyl/5_methyl_CHH-CHG/CHH_context_TF0517.cov.gz.bismark.cov.gz | bedtools intersect -a - -b 1i_MC7.LTR.bed > MC7.CHH.LTR.bismark.cov
