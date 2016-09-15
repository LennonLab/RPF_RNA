#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=5:00:00
#PBS -M wrshoema@indiana.edu
#PBS -m abe
#PBS -j oe
module load cufflinks

mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/expression

GFF=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/prokka/G-Chr1.gff

for bam in /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/*/GSF1115x*.bam
do
  name="$(echo "$bam" | cut -d "/" -f9 )"
  cufflinks -p 4 -o "/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/expression/${name}" \
      --GTF $GFF --no-update-check $bam
done
