#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=10:00:00
#PBS -M wrshoema@indiana.edu
#PBS -m abe
#PBS -j oe

module load sra-toolkit
module load java
module load fastqc
module load python
module load gcc
module load cutadapt
module load tophat2
module load bowtie
cd /N/dc2/projects/Lennon_Sequences/SSRP_2016/testRun/data

#fastq-dump SRR1871622.sra
#fastq-dump SRR1871623.sra

#fastqc SRR1871622.fastq --outdir=FASTQC/
#fastqc SRR1871623.fastq --outdir=FASTQC/

#cutadapt -q 30 -u -30 -o SRR1871622.trim.fastq SRR1871622.fastq
#fastqc SRR1871622.trim.fastq --outdir=FASTQC/


bowtie2 bowtie-build

# r = expected inner distance b/w pair of reads
# --library-type fr-firststrand' for TruSeq
# --rg-id specifies a read group ID
# '--rg-sample' specified a read group sample ID.
tophat2 -p 8 -r 60 --library-type fr-firststrand --rg-id=UHR_Rep1 --rg-sample=UHR_Rep1_ERCC-Mix1 -o UHR_Rep1_ERCC-Mix1 -G $RNA_HOME/refs/hg19/genes/genes_chr22_ERCC92.gtf --transcriptome-index $TRANS_IDX_DIR/ENSG_Genes $RNA_HOME/refs/hg19/bwt/chr22_ERCC92/chr22_ERCC92 $RNA_DATA_DIR/UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz $RNA_DATA_DIR/UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2.fastq.gz
