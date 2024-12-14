#!/bin/bash
## Specify the job name
#SBATCH --job-name=pc_tmhmm_job

## account to charge
#SBATCH -A CLASS_EE282

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=pc_tmhmm_job.err
#SBATCH --output=pc_tmhmm_job.out

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

tmhmm --short < Trinity.fasta.transdecoder.pep > tmhmm.out
