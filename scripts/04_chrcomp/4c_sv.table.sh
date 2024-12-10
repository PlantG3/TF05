#!/bin/bash
# synteny
grep SYN syriout/03*syri.out \
	| grep -e INS -e DEL \
	| awk '($8 - $7)>30000 || ($3-$2)>30000' \
	| cut -f 1-3,6-8,11 \
	| sed 's/.*://' \
	> 4o_gt30kb.syn.INDEL.txt

# SV
awk '$11=="DUP" || $11=="TRANS" || $11=="INV"' syriout/03*syri.out \
	| awk '($8-$7)>50000 || ($3-$2)>50000' \
	| cut -f 1-3,6-8,11 \
	| sed 's/.*://' \
	> 4o_gt50kb.SV.txt

