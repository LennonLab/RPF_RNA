#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=5:00:00
#PBS -M wrshoema@indiana.edu
#PBS -m abe
#PBS -j oe
module load cufflinks

mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/diff_expression
RefIndex=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/bwt/G-Chr1.fa
GFF=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/prokka/G-Chr1.gff

assembly_GTF_list=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/assembly_GTF_list.txt

rm $assembly_GTF_list

for GTF in /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/expression/*/transcripts.gtf
do
  path="$(echo "$GTF" | cut -d "/" -f1-8 )"
  name="$(echo "$GTF" | cut -d "/" -f9 )"
  copy_path="${path}/${name}/$name.gtf"
  cp $GTF $copy_path
  echo $copy_path >> $assembly_GTF_list
done

cuffmerge -p 2 -o /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/diff_expression \
    -g $GFF -s $RefIndex $assembly_GTF_list
