#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=10:00:00
#PBS -M wrshoema@indiana.edu
#PBS -m abe
#PBS -j oe
module load java
module load fastqc

mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped_quality

for folder in /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/*/
do
  name="$(echo "$folder" | cut -d "/" -f9 )"
  cp "${folder}accepted_hits.bam" "${folder}${name}.bam"
  fastqc "${folder}${name}.bam" --outdir=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped_quality
done
