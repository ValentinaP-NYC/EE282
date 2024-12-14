#!/bin/bash
## Specify the job name
#SBATCH --job-name=pc_pep_hmmscan

## account to charge
#SBATCH -A CLASS_EE282

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=pc_hmmscan_pep.err
#SBATCH --output=pc_hmmscan_pep.out

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

#hmmscan --cpu 32 --domtblout xm_TrinotatePFAM.out \
#          /pub/valenp1/repositories/myfirstgitproject/data/processed/trinotate/resources/Trinotate-Trinotate-v4.0.2/Pfam-A.hmm \
#          /pub/valenp1/repositories/myfirstgitproject/data/processed/xm_trinity_out.Trinity.fasta


#hmmscan --cpu 32 --domtblout xm_PepTrinotatePFAM.out \
#          /pub/valenp1/repositories/myfirstgitproject/data/processed/trinotate/resources/Trinotate-Trinotate-v4.0.2/Pfam-A.hmm \
#          /pub/valenp1/repositories/myfirstgitproject/data/processed/trinotate/xm_trinity_out.Trinity.fasta.transdecoder.pep


hmmscan --cpu 32 --domtblout pc_PepTrinotatePFAM.out \
          /pub/valenp1/repositories/myfirstgitproject/data/processed/trinotate/resources/Trinotate-Trinotate-v4.0.2/Pfam-A.hmm \
          /pub/valenp1/repositories/myfirstgitproject/data/processed/trinotate/pc_trinity_out.Trinity.fasta.transdecoder.pep


