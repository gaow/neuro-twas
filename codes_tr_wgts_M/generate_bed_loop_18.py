import numpy as np
import os

fn = np.genfromtxt("filenames18_s.txt", dtype='str')


for curr in fn:
    with open("test.sh", "w+") as f:
        f.write("#!/bin/bash\n\n")
        f.write("module load plink\n")
        f.write("plink --file {} --make-bed --out /scratch/midway2/sxt1229/methylation_train/plinkbed_chr18/{}".format(curr, curr))
    os.system("bash test.sh")
    os.system("rm test.sh")
