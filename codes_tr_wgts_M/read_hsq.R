#need to change chromosome number


setwd("/scratch/midway2/sxt1229/whole_chr_peak_train/weights_chr17") #################

filename_r <- list.files(, full.names = T, pattern = ".hsq")
filename_spl <- unlist(strsplit(filename_r, split = "./" ))
num_even <- seq(from=2,to=length(filename_spl),by=2)
filename <- filename_spl[num_even]
system("touch hsq_chr17.txt")             #######################
for (i in 1:length(filename)) {
  
  aa <- sprintf("cat %s >> hsq_chr17.txt",filename[i])                ####################
  system(aa)
  
}
    
system("mv hsq_chr17.txt ./../")       ####################
