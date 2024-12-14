#!/bin/bash
## Specify the job name
#SBATCH --job-name=XM_trinity_job

## account to charge
#SBATCH -A CLASS_EE282

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=XM_trinity_job.err
#SBATCH --output=XM_trinity_job.out

## Pass the current environment variables
#SBATCH --export=ALL

## Go to current working directory
#SBATCH --chdir=.

## Memory
#SBATCH --mem-per-cpu=6G

# Time
#SBATCH --time=4-00:00:00

# set up mamba
source /pub/valenp1/miniforge3/etc/profile.d/conda.sh
source /pub/valenp1/miniforge3/etc/profile.d/mamba.sh

mamba activate trinity

# outdir path
TRINITY_OUT="/pub/valenp1/repositories/myfirstgitproject/data/processed/xm_trinity_out"


# run trinity on X.mucosus replicates
Trinity --seqType fq --max_memory 190G --CPU 32 --samples_file Xm_trinity_assembly_samples.txt --output "$TRINITY_OUT"  --min_contig_length 200


# outdir path
TRINITY_OUTT="/pub/valenp1/repositories/myfirstgitproject/data/processed/pc_trinity_out"


# run trinity on P.chirus replicates
Trinity --seqType fq --max_memory 190G --CPU 32 --samples_file pc_trinity_assembly_samples.txt --output "$TRINITY_OUTT"  --min_contig_length 200




