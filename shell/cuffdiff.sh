#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=5:00:00
#PBS -M wrshoema@indiana.edu
#PBS -m abe
#PBS -j oe
module load cufflinks

CQ_out=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/cuffquant_out
mkdir -p $CQ_out

GTF=/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/diff_expression/merged.gtf


# cuffquant is not in this version

#for bam in /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/*/GSF1115x*.bam
#do
#  name="$(echo "$bam" | cut -d "/" -f9 )"
#  mkdir -p "${CQ_out}/${name}"
#  cuffquant -p 8 --library-type fr-firststrand --no-update-check \
#      -o "${CQ_out}/${name}" $GTF $bam
#done

#mkdir -p /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/cuffdiff_out

cuffdiff -p 8 -L D,DR,V,VR -o /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/cuffdiff_out \
    --library-type fr-firststrand --no-update-check $GTF \
    /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-D1_S1_R1_001_cleaned/GSF1115x-D1_S1_R1_001_cleaned.bam,/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-D2_S2_R1_001_cleaned/GSF1115x-D2_S2_R1_001_cleaned.bam,/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-D3_S3_R1_001_cleaned/GSF1115x-D3_S3_R1_001_cleaned.bam \
    /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-DR1_S4_R1_001_cleaned/GSF1115x-DR1_S4_R1_001_cleaned.bam,/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-DR2_S5_R1_001_cleaned/GSF1115x-DR2_S5_R1_001_cleaned.bam,/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-DR3_S6_R1_001_cleaned/GSF1115x-DR3_S6_R1_001_cleaned.bam \
    /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-V1_S7_R1_001_cleaned/GSF1115x-V1_S7_R1_001_cleaned.bam,/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-V2_S8_R1_001_cleaned/GSF1115x-V2_S8_R1_001_cleaned.bam,/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-V3_S9_R1_001_cleaned/GSF1115x-V3_S9_R1_001_cleaned.bam \
    /N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-VR1_S10_R1_001_cleaned/GSF1115x-VR1_S10_R1_001_cleaned.bam,/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-VR2_S11_R1_001_cleaned/GSF1115x-VR2_S11_R1_001_cleaned.bam,/N/dc2/projects/Lennon_Sequences/2016_RPF_RNA/data/reads_mapped/GSF1115x-VR3_S12_R1_001_cleaned/GSF1115x-VR3_S12_R1_001_cleaned.bam
