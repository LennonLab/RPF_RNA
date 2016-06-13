# RNA-Seq notes

### Input files

- 1) Raw RNA-Seq data (.fastq)

- 2 Reference genome (.fa)

- 3) Gene annotation (.gtf)

### steps

**1)** Quality control

- FastQC

**2)** Adaptor trimming

- Cutadapt


**3)** Mapping

- Bowtie2/Tophat2
- We can't use BWA since it doesn't make the assumptions necessary for RNA Mapping

**4)** Post-alignment QC

- SAMTools



### References

https://github.com/griffithlab/rnaseq_tutorial/wiki/Alignment
