#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=10:00:00
#PBS -M wrshoema@indiana.edu
#PBS -m abe
#PBS -j oe
module load python
module load gcc
module load cutadapt

mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_clean

for IN in /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_raw/*fastq.gz
do
  name="$(echo "$IN" | cut -d "/" -f9 | cut -d "." -f 1)"
  OUT="/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_clean/${name}_cleaned.fastq.gz"
  cutadapt -q 30 -u 10 -o $OUT $IN
done
