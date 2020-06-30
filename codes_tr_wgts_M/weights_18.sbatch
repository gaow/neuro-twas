#!/bin/bash
#SBATCH --exclusive
#SBATCH --partition=broadwl



cp /scratch/midway2/sxt1229/fusion/cal_weight/* /scratch/midway2/sxt1229/methylation_train/plinkbed_chr18
cp /scratch/midway2/sxt1229/methylation_train/weights_cal_loop_18.py /scratch/midway2/sxt1229/methylation_train/plinkbed_chr18
cp /scratch/midway2/sxt1229/methylation_train/filenames18_s.txt /scratch/midway2/sxt1229/methylation_train/plinkbed_chr18


mkdir /scratch/midway2/sxt1229/methylation_train/weights_chr18
touch /scratch/midway2/sxt1229/methylation_train/weights_chr18/hsq_chr18.txt

module load R
module load plink
module load python

cd /scratch/midway2/sxt1229/methylation_train/plinkbed_chr18

python weights_cal_loop_18.py

mv /scratch/midway2/sxt1229/methylation_train/weights_chr18/hsq_chr18.txt  /scratch/midway2/sxt1229/methylation_train
