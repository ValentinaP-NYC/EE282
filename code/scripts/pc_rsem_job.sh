#!/bin/bash
## Specify the job name
#SBATCH --job-name=pc_bowtie_rsem_job

## account to charge
#SBATCH -A CLASS_EE282

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=pc_bowtie_rsem_job.err
#SBATCH --output=pc_bowtie_rsem_job.out

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

mamba activate trinity

# just prepare reference for alignment and estimation

#align_and_estimate_abundance.pl \
# --transcripts /pub/valenp1/repositories/myfirstgitproject/data/processed/reference_RSEM_quant_pc/pc_trinity_out.Trinity.fasta \
# --est_method RSEM \
# --aln_method bowtie2 \
# --trinity_mode \
# --prep_reference

# run rsem to align reads for each PC sample to PC pooled trinity assembly

align_and_estimate_abundance.pl \
 --transcripts /pub/valenp1/repositories/myfirstgitproject/data/processed/reference_RSEM_quant_pc/pc_trinity_out.Trinity.fasta \
 --seqType fq \
 --SS_lib_type FR \
 --thread_count 32 \
 --aln_method bowtie2 \
 --coordsort_bam \
 --est_method RSEM \
 --samples_file /pub/valenp1/repositories/myfirstgitproject/data/processed/rsem_out/PC_trinity_assembly_samples.txt \
 --trinity_mode \
 --output_dir ./abundances
