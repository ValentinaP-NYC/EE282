# Homework 4 for EE282 

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
# Generate reports for genome partitions 

## Sequnces less than 100kb
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

```bash

bioawk -c fastx '{ print $name, length($seq), gc($seq) }' filtered_100kb.fasta | sort -k2,2nr > sorted_lengths_100kb.txt

bioawk -c fastx '{ print $name, length($seq), gc($seq) }' filtered_100kb_plus.fasta | sort -k2,2nr > sorted_lengths_100kb_plus.txt

```
```r
library(ggplot2)

# Load sequence length data for sequences ≤ 100kb
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

```bash
# plot cumulative sequence size sorted from largest to smallest sequences

plotCDF sorted_lengths_100kb.txt > cdf_100kb.png

plotCDF sorted_lengths_100kb_plus.txt  > cdf_100kb_plus.png

```

## plot gc content

```r

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


