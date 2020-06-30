for (i in 18:22){
  
  
  filename <- paste0("hsq_chr",i,".txt")
  
  hsq <- read.table(filename)        ##########
  hsq <- hsq[!duplicated(hsq$V1),]
  colnames(hsq) <- c('ID','heritability','se','p-value')
  
  file_out <- paste0("heritability_chr",i)
  jpeg(file_out)              ###########
  hist(hsq$heritability, main = file_out)
  abline(v = 0.01,col = "red" )
  dev.off()
  
  
  
  
}
    

  