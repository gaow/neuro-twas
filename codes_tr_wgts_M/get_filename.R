setwd("/scratch/midway2/sxt1229/methylation_train/chr5_pedmap/")    #####################

filename_r <- list.files(, full.names = T, pattern = ".ped")
filename_spl <- unlist(strsplit(filename_r, split = "./" ))
num_even <- seq(from=2,to=length(filename_spl),by=2)
filename_m <- filename_spl[num_even]

filename_spl <- unlist(strsplit(filename_m, split = ".ped" ))

filename <- filename_spl

setwd("/scratch/midway2/sxt1229/methylation_train/")
write.table(filename, file = "filenames5_s.txt", row.names = F, col.names = F, quote = F  )   ############
    
