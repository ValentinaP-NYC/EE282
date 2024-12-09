#!/bin/bash
## Specify the job name
#SBATCH --job-name=hw4_busco_ISO1_job

## account to charge
#SBATCH -A CLASS_EE282

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=hw4_busco_ISO1_job.err
#SBATCH --output=hw4_busco_ISO1_job.out

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

mamba activate busco

# run busco on assembly
# file /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa

# busco --list-datasets
# use diptera_odb10

busco -f -c 32 -m genome -i /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa -o ISO1_Hifiasm --lineage diptera_odb10 --out_path /data/homezvol2/valenp1/myrepos/ee282/data/processed/busco




