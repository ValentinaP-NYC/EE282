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

# run hifiasm
hifiasm -o /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm \
 -t 32 /data/homezvol2/valenp1/myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.fasta.gz


# convert gfa for fasta for */bp.p_ctg.gfa

awk '/^S/{print ">"$2;print $3}' /data/homezvol2/valenp1//myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.gfa > /data/homezvol2/valenp1//myrepos/ee282/data/raw/ISO1_Hifi_AdaptorRem.40X.asm.bp.p_ctg.fa
