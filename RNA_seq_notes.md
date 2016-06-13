# RNA-Seq notes

### Input files

- 1) Raw RNA-Seq data (.fastq)

- 2 Reference genome (.fa)

- 3) Gene annotation (.gtf)

### Steps

**1)** Quality control

- FastQC

**2)** Adaptor trimming

- Cutadapt


**3)** Mapping

- Bowtie2/Tophat2
- We can't use BWA since it doesn't make the assumptions necessary for RNA Mapping

**4)** Post-alignment QC

- SAMTools

**5)** Expression

- Cufflinks and Cuffdiff

**6)** Differential expression

- Cufflinks and Cuffdiff

**7) Visualization / data manipulation**

- CummeRbund (R package)

### References

- https://github.com/griffithlab/rnaseq_tutorial/wiki/Alignment

- http://www.sciencedirect.com/science/article/pii/S1369527414001787

- http://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-13-734

- http://www.rna-seqblog.com/bacterial-transcriptomics/

- (Not for this project, but potentially useful for the future) https://github.com/hopkinsmarinestation/Population-Genomics-via-RNAseq
