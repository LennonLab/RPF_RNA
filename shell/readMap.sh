#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=10:00:00
#PBS -M wrshoema@indiana.edu
#PBS -m abe
#PBS -j oe
module load bowtie2
module load tophat2

mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped

RefIndex=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/bwt/G-Chr1
GFF=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/prokka/G-Chr1.gff

for IN in /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_clean/*fastq.gz
do
  name="$(echo "$IN" | cut -d "/" -f9 | cut -d "." -f 1)"
  OUT="/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/${name}"
  mkdir -p $OUT
  tophat2 -p 4 -G $GFF -o $OUT --no-novel-juncs $RefIndex $IN
done
