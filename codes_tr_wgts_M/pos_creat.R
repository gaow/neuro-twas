setwd("/scratch/midway2/sxt1229/methylation_train/WEIGHTS/methylation/") #################

filename_r <- list.files(, full.names = T, pattern =".RDat")
filename_spl <- unlist(strsplit(filename_r, split = "./" ))
num_even <- seq(from=2,to=length(filename_spl),by=2)
num_odd <- seq(from=1,to=length(filename_spl),by=2)
filename <- filename_spl[num_even]

str <- rep("methylation/", length(filename))

pos_1 <- paste0(str,filename)

pos_2 <- unlist(strsplit(filename, split = ".wgt.RDat" ))

chr <- unlist(strsplit(pos_2,split = "_"))[num_odd]
chr_num <- unlist(strsplit(chr,split = "chr"))[num_even]

pos_3 <- chr_num     #####################

tmp <- unlist(strsplit(pos_2, split = "_" ))
pos_4 <- tmp[num_even]
pos_5 <- pos_4

pos <- cbind(pos_1,pos_2,pos_3,pos_4,pos_5)
colnames(pos) <- c('WGT','ID','CHR','P0','P1')


setwd("/scratch/midway2/sxt1229/methylation_train/")
write.table(pos, "posfile_1.pos", col.names = T, row.names = F, quote = F, sep = "\t")         ################
