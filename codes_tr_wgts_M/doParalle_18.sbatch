#!/bin/bash
#SBATCH --exclusive
#SBATCH --partition=broadwl
#SBATCH --ntasks-per-node=16
#SBATCH --nodes=2
#SBATCH --time=24:00:00

module load R
R CMD BATCH --no-save --no-restore chr18_pedmap_w.R
