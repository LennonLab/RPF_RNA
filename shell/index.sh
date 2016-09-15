#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=10:00:00
#PBS -M wrshoema@indiana.edu
#PBS -m abe
#PBS -j oe
module load bowtie2
module load tophat

mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/bwt

bowtie2-build /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/prokka/G-Chr1.fna \
    /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/bwt/G-Chr1
