# Homework 4 for EE282

Author: Valentina Peña

## Calculate summaries of the genome for partitons

``` bash
cd ~/myrepos/ee282/data/raw

# Download chromosome data 
wget "https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/fasta/dmel-all-chromosome-r6.48.fasta.gz"

wget "https://ftp.flybase.net/releases/current/dmel_r6.60/fasta/md5sum.txt"

# The output is be1f79c5922a4bf08548a2a4553e4d5f which matches to the checksum on FlyBase
md5sum -c md5sum.txt # returns OK
```

``` bash
# Generate reports for genome partitions 

## Sequnces less than 100kb using scaffold file
faFilter -maxSize=100000 <(gunzip -c dmel-all-chromosome-r6.48.fasta.gz) filtered_100kb.fasta

faSize -tab filtered_100kb.fasta > filtered_100kb_fa_size_output.txt

less filtered_100kb_fa_size_output.txt
## Sequences greater than 100kb
 
faFilter -minSize=100000 <(gunzip -c dmel-all-chromosome-r6.48.fasta.gz) filtered_100kb_plus.fasta

faSize -tab filtered_100kb_plus.fasta > filtered_100kb_plus_fa_size_output.txt

less filtered_100kb_plus_fa_size_output.txt
```

# Generate plots for genome partititons

## plot sequence length

``` bash
bioawk -c fastx '{ print $name, length($seq), gc($seq) }' filtered_100kb.fasta | sort -k2,2nr > sorted_lengths_100kb.txt

bioawk -c fastx '{ print $name, length($seq), gc($seq) }' filtered_100kb_plus.fasta | sort -k2,2nr > sorted_lengths_100kb_plus.txt
```

``` r
library(ggplot2)

# Load sequence length data for sequences ≤ 100kb
setwd("~/remote_mount/myrepos/ee282/data/raw")

sequence_lengths_100kb<- read.table("sorted_lengths_100kb.txt", header = FALSE, sep = "\t")

# Add column names manually
colnames(sequence_lengths_100kb) <- c("Sequence_Name", "Length", "GC_Content")

# Plot histogram for Sequence Length Distribution (≤ 100kb) using ggplot2 with log scale
ggplot(data = sequence_lengths_100kb, aes(x = Length)) +
  geom_histogram(bins = 30, color = "black", fill = "pink") +
  scale_x_log10() +  # Set x-axis to log scale
  labs(title = "Sequence Length Distribution (≤ 100kb)", x = "Length(log scale)", y = "Frequency") +
  theme_minimal()

# Load sequence length data for sequences > 100kb
sequence_lengths_100kb_plus<- read.table("sorted_lengths_100kb_plus.txt", header = FALSE, sep = "\t")

# Add column names manually
colnames(sequence_lengths_100kb_plus) <- c("Sequence_Name", "Length", "GC_Content")

# Plot histogram for Sequence Length Distribution (≤ 100kb) using ggplot2 with log scale
ggplot(data = sequence_lengths_100kb_plus, aes(x = Length)) +
  geom_histogram(bins = 30, fill = "dark green",color = "black") +
  scale_x_log10() +  # Set x-axis to log scale
  labs(title = "Sequence Length Distribution (>100kb)", x = "Length(log scale)", y = "Frequency") +
  theme_minimal()
```

## plot gc content

``` r

# Plot histogram for GC% Distribution (≤ 100kb) using ggplot2
ggplot(data = sequence_lengths_100kb, aes(x = GC_Content)) +
  geom_histogram(bins = 30, color = "black", fill = "pink") +
  labs(title = "GC Content Distribution (≤ 100kb)", x = "GC_Content", y = "Frequency") +
  theme_minimal()

# Plot histogram for GC% Distribution (> 100kb) using ggplot2
ggplot(data = sequence_lengths_100kb_plus, aes(x = GC_Content)) +
  geom_histogram(bins = 30, fill = "dark green",color = "black") +
  labs(title = "GC Content Distribution (>100kb)", x = "GC_content", y = "Frequency") +
  theme_minimal()
```

``` bash
# plot cumulative sequence size sorted from largest to smallest sequences
cut -f2 sorted_lengths_100kb.txt > sorted_lengths_copy_100kb.txt
plotCDF sorted_lengths_copy_100kb.txt cdf_100kb.png
![Cumulative Distribution Function](https://raw.githubusercontent.com/ValentinaP-NYC/ee282/homework4/cdf_100kb.png)

cut -f2 sorted_lengths_100kb_plus.txt > sorted_lengths_copy_100kb_plus.txt
plotCDF sorted_lengths_copy_100kb_plus.txt cdf_100kb_plus.png
```

``` bash
# use faSize to calculate lengths for ISO1 hifi contig 

faSize -detailed /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa > /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa.contig_sizes.txt

# sort lengths

sort -rnk 2,2 /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa.contig_sizes.txt > /data/homezvol2/valenp1/myrepos/ee282/data/processed/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa.contig_sizes_sorted.txt

# calculate the n50

awk '{
    sum_length += $2;          # Sum the lengths in column 2
    sizes[NR] = $2;       # Store the lengths
}
END {
    half = sum_length / 2;     # Calculate half of the total length
    for (i = 1; i <= NR; i++) {
        sum += sizes[i];  # Accumulate lengths
        if (sum >= half) {
            print "N50:", sizes[i]; # Print N50 when cumulative sum reaches half
            break;
        }
    }
}' /data/homezvol2/valenp1/myrepos/ee282/data/processed/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa.contig_sizes_sorted.txt

# the answer N50: 21715751
# 21.72 Mb
```
``` bash
# for the ref dmel on flyable
# use faSize to calculate lengths

# Release 6 contigs

faSplitByN /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.fasta.gz /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.ctg.fa

gzip /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.ctg.fa

faSize -detailed /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.ctg.fa.gz > /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.contig_sizes.txt

# sort lengths

sort -rnk 2,2 /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.contig_sizes.txt > /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.contig_sizes_sorted.txt


# the dmel-all

awk '{
    sum_length += $2;          # Sum the lengths in column 2
    sizes[NR] = $2;       # Store the lengths
}
END {
    half = sum_length / 2;     # Calculate half of the total length
    for (i = 1; i <= NR; i++) {
        sum += sizes[i];  # Accumulate lengths
        if (sum >= half) {
            print "N50:", sizes[i]; # Print N50 when cumulative sum reaches half
            break;
        }
    }
}' /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.contig_sizes_sorted.txt

# the answer N50: 21485538
# 21.5 Mb

# 21.5 Mb is the contiguous n50 listed on flybase for r6 via the link available
```

``` bash
# Release 6 scaffolds

faSize -detailed dmel-all-chromosome-r6.48.fasta.gz > dmel-all-chromosome-r6.48.unsorted.namesizes.txt

sort -rnk 2,2 dmel-all-chromosome-r6.48.unsorted.namesizes.txt > dmel-all-chromosome-r6.48.scaff_sizes_sorted.txt

cut -f2 dmel-all-chromosome-r6.48.scaff_sizes_sorted.txt > dmel-all-chromosome-r6.48.scaffp_sizes_sorted.txt

# Plot CDF for ISO1 Hifi .ctg / dmel-r6.ctg / dmel-r6.scaff
plotCDF ./*_copy.txt CDF.png

```

``` bash
# run hifiasm, the sbatch script can be found at ee282/code/scripts

hifiasm -o /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm \
 -t 32 /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.fasta.gz

# convert gfa for fasta for */bp.p_ctg.gfa

awk '/^S/{print ">"$2;print $3}' /data/homezvol2/valenp1//myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.gfa > /data/homezvol2/valenp1//myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa

```
# BUSCO Results Summary for ISO1
``` bash
# run busco, the sbatch script can be found at ee282/code/scripts
busco -f -c 32 -m genome -i /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa -o ISO1_Hifiasm --lineage diptera_odb10 --out_path /data/homezvol2/valenp1/myrepos/ee282/data/processed/busco
```

| **Category**               | **Metric**                           | **Value**                   |
|----------------------------|---------------------------------------|-----------------------------|
| **Results Summary**        | Complete BUSCOs (C)                  | 3272 (99.6%)               |
|                            | ├── Single-copy BUSCOs (S)           | 3265 (99.4%)               |
|                            | └── Duplicated BUSCOs (D)            | 7 (0.2%)                   |
|                            | Fragmented BUSCOs (F)                | 5 (0.2%)                   |
|                            | Missing BUSCOs (M)                   | 8 (0.2%)                   |
|                            | Total BUSCO groups searched (n)      | 3285                       |
|                            | BUSCO groups with internal stops     | 66                         |
| **Assembly Statistics**    | Number of scaffolds                  | 148                        |
|                            | Number of contigs                    | 148                        |
|                            | Total length                         | 159,127,788 bp             |
|                            | Percent gaps                         | 0.000%                     |
|                            | Scaffold N50                         | 21 MB                      |
|                            | Contigs N50                          | 21 MB                      |


# BUSCO Results Summary for Release 6 Dmel contig
``` bash
# run busco, the sbatch script can be found at ee282/code/scripts
busco -f -c 32 -m genome -i /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.ctg.fa -o dmel.r6_ctg --lineage diptera_odb10 --out_path /data/homezvol2/valenp1/myrepos/ee282/data/processed/hmw4_busco
```
| **Category**               | **Metric**                           | **Value**                   |
|----------------------------|---------------------------------------|-----------------------------|
| **Results Summary**        | Complete BUSCOs (C)                  | 3276 (99.7%)               |
|                            | ├── Single-copy BUSCOs (S)           | 3267 (99.5%)               |
|                            | └── Duplicated BUSCOs (D)            | 9 (0.3%)                   |
|                            | Fragmented BUSCOs (F)                | 5 (0.2%)                   |
|                            | Missing BUSCOs (M)                   | 4 (0.1%)                   |
|                            | Total BUSCO groups searched (n)      | 3285                       |
|                            | BUSCO groups with internal stops     | 64                         |
| **Assembly Statistics**    | Number of scaffolds                  | 2442                       |
|                            | Number of contigs                    | 2442                       |
|                            | Total length                         | 142,573,024 bp             |
|                            | Percent gaps                         | 0.000%                     |
|                            | Scaffold N50                         | 21 MB                      |
|                            | Contigs N50                          | 21 MB                      |

