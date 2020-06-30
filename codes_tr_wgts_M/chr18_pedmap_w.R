#library("tidyverse")
library(doParallel)
registerDoParallel(cores = (Sys.getenv("SLURM_NTASKS_PER_NODE")))


load("genotype.rdata")
load("methylation.rdata")

genotype_1 <- genotype[,1:9]
genotype_2 <- genotype[,colnames(genotype) %in% colnames(methylation_origin)[3:ncol(methylation_origin)]]

genotype_2 <- round(genotype_2) 
genotype_2[is.na(genotype_2)] <- 0

#na
genotype <- cbind(genotype_1,genotype_2)

#count <- 0
#filename_del <- c()
#count_1 <- 0
#filename_save <- c()

methylation_origin1 <- methylation_origin[methylation_origin$chr=="chr18",]###############
methylation_origin2 <- methylation_origin[methylation_origin$chr=="chr19",]
#methylation_origin3 <- methylation_origin[methylation_origin$chr=="chr17",]

methylation_origin <- rbind(methylation_origin1,methylation_origin2)


for (i in 1:nrow(methylation_origin)) {
  #nrow(methylation_origin)
  pos_l <- max(as.numeric(methylation_origin$pos[i]) - 100000,0)
  pos_u <- as.numeric(methylation_origin$pos[i]) + 100000
  
  geno_pre <- genotype[genotype$CHROM == methylation_origin$chr[i],]
  geno_select_final <- geno_pre[geno_pre$POS %in% pos_l:pos_u,]
  
  
  if (nrow(geno_select_final)!=0){
    #count_1 <- count_1 + 1
    #filename_save[count_1] <- paste(methylation_origin$chr[i], methylation_origin$pos[i], sep = "_")
    ##geno_snp is the genotype of each snp locus and will be used in .ped files. 
    ##column 7 onwards.
    geno_select_final <- t(geno_select_final)
    geno_snp <- matrix(data = NA,nrow(geno_select_final)-9,ncol(geno_select_final)*2)
    rownames(geno_snp) <- rownames(geno_select_final)[10:nrow(geno_select_final)]
    for (k in {10:nrow(geno_select_final)}){
      #nrow(geno_select_final)
      for (t in {1:ncol(geno_select_final)}){
        #ncol(geno_select_final)
        if (geno_select_final[k,t] == 0){
          geno_snp[k-9,t*2-1] <- as.character(geno_select_final[4,t])
          geno_snp[k-9,t*2] <- as.character(geno_select_final[4,t])
        }
        else if (geno_select_final[k,t] == 1){
          geno_snp[k-9,t*2-1] <- as.character(geno_select_final[4,t])
          geno_snp[k-9,t*2] <- as.character(geno_select_final[5,t])
        }
        else if (geno_select_final[k,t] == 2){
          geno_snp[k-9,t*2-1] <- as.character(geno_select_final[5,t])
          geno_snp[k-9,t*2] <- as.character(geno_select_final[5,t])
        }
        #else if (geno_select_final[k,t] == NA){
        #  geno_snp[k-9,t*2-1] <- NA
        #  geno_snp[k-9,t*2] <- NA
        #}
      }
      
    }
    ####ped file: FID, IID, PID, MID, SEX, PHENOTYPE, GENOTYPE
    ped <- matrix(data = NA, nrow(geno_snp),5)
    ped[,1] <- integer(nrow(ped))
    for (m in {1:nrow(ped)}) {
      ped[m,2] <- unlist(strsplit(rownames(geno_snp)[m],"X"))[2]
    }
    ped[,3] <- integer(nrow(ped))
    ped[,4] <- integer(nrow(ped))
    ped[,5] <- integer(nrow(ped))
    rownames(ped) <- rownames(geno_snp)
    ###needs a loop here
    ped_tmp <- t(methylation_origin[i,3:ncol(methylation_origin)])
    ped <-merge(ped, ped_tmp, by = "row.names", all = TRUE)
    rownames(ped)<- ped[,"Row.names"]
    ped <- ped[,-1]
    ped <- merge(ped, geno_snp, by = "row.names", all = TRUE)
    rownames(ped)<- ped[,"Row.names"]
    ped <- ped[,-1]
    
    filename <- paste(methylation_origin$chr[i], methylation_origin$pos[i], sep = "_")
    filename_ped <- paste0(filename, ".ped")
    setwd("/scratch/midway2/sxt1229/methylation_train/chr18_pedmap/")######################
    write.table(ped, file = filename_ped, quote = F, sep = " ", row.names = F,col.names = F)
    
    ######.map file: chromosome,   rs, genetic distance, position
    
    map <- matrix(data = NA,ncol(geno_select_final),4)
    for (m in {1:nrow(map)}) {
      map[m,1] <- unlist(strsplit(geno_select_final[1,m],"chr"))[2]
    }
    map[,2] <- geno_select_final[3,]
    map[,3] <- integer(nrow(map))
    map[,4] <- geno_select_final[2,]
    
    filename_map <- paste0(filename, ".map")
    setwd("/scratch/midway2/sxt1229/methylation_train/chr18_pedmap/")##################
    write.table(map, file = filename_map, quote = F, sep = " ", row.names = F,col.names = F)
     
    }
  #else {
    #count <- count +1
    #filename_del[count] <- paste(methylation_origin$chr[i], methylation_origin$pos[i], sep = "_")
    #next
  
  #}
}
#setwd("/scratch/midway2/sxt1229/whole_chr_peak_train/")
#save(filename_del,file = "filenamedel1.rdata") ######################33
#save(filename_save,file = "filenamesave1.rdata")         ##########################

getDoParWorkers()

parallel_time["elapsed"]
