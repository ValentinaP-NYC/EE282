# Homework 3 for EE282 

Author: Valentina Peña

## Calculate summaries of the genome

```bash
cd ~/myrepos/ee282/data/raw

# Download chromosome data 
wget "https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/fasta/dmel-all-chromosome-r6.48.fasta.gz"

wget "https://ftp.flybase.net/releases/current/dmel_r6.60/fasta/md5sum.txt"

# The output is be1f79c5922a4bf08548a2a4553e4d5f which matches to the checksum on FlyBase
md5sum -c md5sum.txt # returns OK
```

```bash
# Generate a report using faSize 
faSize -tab dmel-all-chromosome-r6.48.fasta.gz > fa_size_output.txt

less fa_size_output.txt
```

| Metric          | Value           |
|-----------------|-----------------|
| baseCount       | 143726002       |
| nBaseCount      | 1152978         |
| realBaseCount   | 142573024       |
| upperBaseCount  | 142573024       |
| lowerBaseCount  | 0               |
| seqCount        | 1870            |
| fileCount       | 1               |
| meanSize        | 76858.8         |
| SdSize          | 1382100.2       |
| minSize         | 544             |
| minSeqSize      | 211000022279089 |
| maxSize         | 32079331        |
| maxSeqSize      | 3R              |
| medianSize      | 1577            |
| nCountMean      | 616.6           |
| nCountSd        | 6960.7          |
| upperCountMean  | 76242.3         |
| upperCountSd    | 1379508.4       |
| lowerCountMean  | 0.0             |
| lowerCountSd    | 0.0             |
| fracMasked      | 0.00            |
| fracRealMasked  | 0.00            |


## Summarize annotation file

```bash
# Download annotation info
wget "https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/gtf/dmel-all-r6.48.gtf.gz"

wget -O md5sum_2.txt "https://ftp.flybase.net/releases/current/dmel_r6.60/gtf/md5sum.txt"

# The output is e13fa4e210bb47378ac2797cf78d69b3 which matches to the checksum on FlyBase
md5sum -c md5sum_2.txt # returns OK

```

#### Total number of features of each type 

```bash
# Sort by feature type and get a count in reverse numerical order
bioawk -c gff '$feature !~ /^#/ {print $feature}' dmel-all-r6.48.gtf.gz | sort | uniq -c | sort -rnk1 > feature_counts.txt

less feature_counts.txt

```

| Feature_Type  | Count   |
|---------------|---------|
| exon          | 190050  |
| CDS           | 163242  |
| 5UTR          | 46802   |
| 3UTR          | 33738   |
| start_codon   | 30885   |
| stop_codon    | 30825   |
| mRNA          | 30799   |
| gene          | 17896   |
| ncRNA         | 3053    |
| miRNA         | 485     |
| pseudogene    | 365     |
| tRNA          | 312     |
| snoRNA        | 300     |
| pre_miRNA     | 262     |
| rRNA          | 115     |
| snRNA         | 32      |


#### Total number of genes per chromosome arm 

```bash
# Extract only genes that are found 2L|2R|3L|3R|4|X|Y arms
bioawk -c gff '$feature == "gene" && ($seqname ~ /^(2L|2R|3L|3R|4|X|Y)$/) { chr_count[$seqname]++ } \
END { for (chr in chr_count) print chr, chr_count[chr] }' dmel-all-r6.48.gtf.gz | sort -k2,2nr > chromosome_gene_counts.txt

less chromosome_gene_counts.txt
```

| Chromosome | Count |
|------------|-------|
| 3R         | 4227  |
| 2R         | 3653  |
| 2L         | 3515  |
| 3L         | 3489  |
| X          | 2708  |
| 4          | 114   |
| Y          | 113   |
