import numpy as np
import os

fn = np.genfromtxt("filenames18_s.txt", dtype='str')


for curr in fn:
    with open("test.sh", "w+") as f:
        f.write("#!/bin/bash\n\n")
	f.write("touch TMP.tmp\n")
        f.write("module load R\n")
	f.write("Rscript FUSION.compute_weights.R --bfile {} --tmp TMP.tmp --out /scratch/midway2/sxt1229/methylation_train/weights_chr18/{} --models lasso,enet,top1 --PATH_plink=/software/plink-1.90b6.9-el7-x86_64/plink  --PATH_gcta=/scratch/midway2/sxt1229/methylation_train/plinkbed_chr18/gcta_nr_robust  --save_hsq".format(curr,curr))
    os.system("touch TMP.tmp")
    os.system("bash test.sh")
    os.system("cat /scratch/midway2/sxt1229/methylation_train/weights_chr18/{}.hsq >> /scratch/midway2/sxt1229/methylation_train/weights_chr18/hsq.txt".format(curr))
    os.system("rm test.sh")

	

