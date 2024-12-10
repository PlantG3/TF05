#!/bin/bash

# basecalling
## Nanopore data (input fullpaths of the directories containing a fast5 subdirectory)
export fast5_directories="
/fastscratch/liu3zhen/cache/4_ont/MC5
"
export guppy_model="/homes/liu3zhen/software/guppy/ont-guppy-cpu/data/dna_r9.4.1_450bps_hac.cfg"
export basecall_narray=5000
export basecall_cpus=8

# Canu assembly
export out=TF05-1MC5
export asm_version="v0.1"
export genomeSize="45m"
export minReadLength=10000
export minOverlapLength=5000
export rawErrorRate=0.2
export correctedErrorRate=0.05
export corOutCoverage=40

# polishing
np_prefix=np
np_ncpu=8
np_mem_per_cpu=6g

## Illumina data
export pe1=/bulk/liu3zhen/research/projects/mini2020/main_sl/01_TF05-1/0-Illumina/1-trim/MC5-1-wg_S4_L001.R1.pair.fq.gz
export pe2=/bulk/liu3zhen/research/projects/mini2020/main_sl/01_TF05-1/0-Illumina/1-trim/MC5-1-wg_S4_L001.R2.pair.fq.gz

## reference
#export ref=../lib/pasmannot/data/B71Ref2.fasta
export ref=/bulk/liu3zhen/research/projects/mini2020/main_ms/00_data/03_asm/TF05-1MC7/TF05-1MC7v1.fasta

# go to working directory
export mypath=`realpath ../`

# vbz plugin
export HDF5_PLUGIN_PATH=/homes/liu3zhen/software/asm_package/vbz/ont-vbz-hdf-plugin-1.0.1-Linux/usr/local/hdf5/lib/plugin

