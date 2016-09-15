#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=10:00:00
#PBS -M wrshoema@indiana.edu
#PBS -m abe
#PBS -j oe
module load java
module load fastqc
module load bowtie2
module load tophat2
module load python
module load gcc
module load cutadapt
module load cufflinks


# Index reference
mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/bwt
bowtie2-build /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/prokka/G-Chr1.fna \
    /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/bwt/G-Chr1

# copy reference to index folder
cp /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/prokka/G-Chr1.fna \
    /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/bwt/G-Chr1.fa


# Asess quality of FASTQ files
mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_quality

for file in /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_raw/*fastq.gz
do
  fastqc "$file" --outdir=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_quality
done

# Trim the reads
mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_clean

for IN in /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_raw/*fastq.gz
do
  name="$(echo "$IN" | cut -d "/" -f9 | cut -d "." -f 1)"
  OUT="/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_clean/${name}_cleaned.fastq.gz"
  cutadapt -q 30 -u 10 -o $OUT $IN
done

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

mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped_quality

for folder in /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/*/
do
  name="$(echo "$folder" | cut -d "/" -f9 )"
  cp "${folder}accepted_hits.bam" "${folder}${name}.bam"
  fastqc "${folder}${name}.bam" --outdir=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped_quality
done

mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/expression

for bam in /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/*/GSF1115x*.bam
do
  name="$(echo "$bam" | cut -d "/" -f9 )"
  cufflinks -p 4 -o "/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/expression/${name}" \
      --GTF $GFF --no-update-check $bam
done

# cuffmerge
mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/diff_expression
RefIndexFasta=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reference/KBS0714/bwt/G-Chr1.fa
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
    -g $GFF -s $RefIndexFasta $assembly_GTF_list


# Cuffdiff
