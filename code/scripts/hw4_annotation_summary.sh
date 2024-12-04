#!/bin/bash
## Specify the job name
#SBATCH --job-name=hw4_hifiasm_job

## account to charge
#SBATCH -A CLASS_EE282

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=hw4_hifiasm_job.err
#SBATCH --output=hw4_hifiasm_job.out

## Pass the current environment variables
#SBATCH --export=ALL

## Go to current working directory
#SBATCH --chdir=.

## Memory
#SBATCH --mem-per-cpu=6G

# Time
#SBATCH --time=2-00:00:00

# set up mamba
source /pub/valenp1/miniforge3/etc/profile.d/conda.sh
source /pub/valenp1/miniforge3/etc/profile.d/mamba.sh

mamba activate ee282

# use faSize to calculate lengths

faSize -detailed /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa > /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa.contig_sizes.txt

# sort lengths

sort -rnk 2,2 /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa.contig_sizes.txt > /data/homezvol2/valenp1/myrepos/ee282/data/processed/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa.contig_sizes_sorted.txt


#

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

# 21.5 Mb is the contiguous n50 listed on flybase for 


# for the ref duel on flyable

# use faSize to calculate lengths

faSize -detailed /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.fasta.gz > /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.fasta.gz.contig_sizes.txt

# sort lengths

sort -rnk 2,2 /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.fasta.gz.contig_sizes.txt > /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.fasta.gz.contig_sorted_sizes.txt


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
}' /data/homezvol2/valenp1/myrepos/ee282/data/raw/dmel-all-chromosome-r6.48.fasta.gz.contig_sizes.txt

# the answer N50: 28110227
# 28.11 Mb

