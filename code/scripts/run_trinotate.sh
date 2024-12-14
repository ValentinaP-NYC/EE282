#!/bin/bash
## Specify the job name
#SBATCH --job-name=xm_blast_job

## account to charge
#SBATCH -A CLASS_EE282

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=xm_blast_trinotate.err
#SBATCH --output=xm_blast_trinotate.out

## Pass the current environment variables
#SBATCH --export=ALL

## Go to current working directory
#SBATCH --chdir=.

## Memory
#SBATCH --mem-per-cpu=4G

# Time
#SBATCH --time=2-00:00:00

# set up mamba
source /pub/valenp1/miniforge3/etc/profile.d/conda.sh
source /pub/valenp1/miniforge3/etc/profile.d/mamba.sh

mamba activate trinotate

#
#/pub/valenp1/miniforge3/envs/trinotate/bin/Trinotate --create \
#           --db /pub/valenp1/repositories/myfirstgitproject/data/processed/resources/trinotate/myTrinotate.sqlite \
#           --trinotate_data_dir /pub/valenp1/repositories/myfirstgitproject/data/processed/trinotate/resources


# search Trinity transcripts
blastx -query /pub/valenp1/repositories/myfirstgitproject/data/processed/xm_trinity_out.Trinity.fasta -db /pub/valenp1/repositories/myfirstgitproject/data/processed/trinotate/resources/Trinotate-Trinotate-v4.0.2/uniprot_sprot.pep -num_threads 32 -max_target_seqs 1 -outfmt 6 > xm_blastx.outfmt6

# search Transdecoder-predicted proteins
blastp -query xm_trinity_out.Trinity.fasta.transdecoder.pep -db /pub/valenp1/repositories/myfirstgitproject/data/processed/trinotate/resources/Trinotate-Trinotate-v4.0.2/uniprot_sprot.pep -num_threads 32 -max_target_seqs 1 -outfmt 6 > xm_blastp.outfmt6



