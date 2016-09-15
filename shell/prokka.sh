####Note#####
# This script runs on my personal mac. Prokka is not installed on dc2

cd /Users/WRShoemaker/github/RPF_RNA/Pangenome/Micrococcus_genomes/FASTA

for i in *.fna
do
  iType="$(echo "$i" | cut -d "." -f1-1)"
  echo "$iType"
  OUT="/Users/WRShoemaker/github/RPF_RNA/Pangenome/Micrococcus_genomes/Annotated/${iType}"
  prokka --compliant --centre I --outdir $OUT --locustag G --prefix G-Chr1 $i --force
done
