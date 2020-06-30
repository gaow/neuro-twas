#!/bin/bash
#SBATCH --exclusive
#SBATCH --partition=broadwl


mkdir plinkbed_chr18

cp generate_bed_loop_18.py ./chr18_pedmap
cp filenames18_s.txt ./chr18_pedmap

cd chr18_pedmap

module load plink
module load python

python generate_bed_loop_18.py




