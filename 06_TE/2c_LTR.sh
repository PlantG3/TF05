ln -s /bulk/liu3zhen/research/projects/mini2020/main_sl/01_TF05-1/1-MC7/1f_edta/TF05-1MC7Ref1.fasta.mod.EDTA.raw/LTR/TF05-1MC7Ref1.fasta.mod.pass.list .
bedtools getfasta -fi ~/references/fungi/magnaporthe/TF05-1MC7Ref1/genome/TF05-1MC7Ref1.fasta -bed 1i_pass.LTR.bed -fo 1o_pass.LTR.fasta -nameOnly

