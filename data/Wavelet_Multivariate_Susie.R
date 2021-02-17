
###################################################
#Perform Multivariate Susie on wavelet coefficients
###################################################

#input

#Y functionnal phenotype, matrix of size N by size 2^J
#G genotype matrix, matrix of size n by p in the current version all the elements have to be 0 or 1
#L the number of effect to fit (if not specified =2)
#my_col_pos color of the points for the alpha plot (for simulation)
#is.flash logical, set as FLASE if true use flash based prior for the mixture
#gen_cov logical, set as FALSE, if true use hand made wavelet correlation prior for the mixture
#output


#fitted_func
#pip
#m_susie: the fitted model by mmbr::msusie

library(grove)

Wave_MSusie <- function(Y,G, L=2,  plot_out =TRUE,my_col_pos, is.flash = FALSE, gen_cov=FALSE)
{
  if( missing(my_col_pos))
  {
    my_col_pos <- rep( "black", dim(G)[2])
  }


  P <- dim(G)[2]  #number of covariates
  N <- dim(G)[1]  #number of individuals
  m <- dim(Y)[2]  #number of d wavelet coefficietns, assuming dim(Y)[2]= 2^J
  lev_res <- which(m/(2^(1:10)) ==1) #assuming dim(Y)[2]= 2^J

  #putting the data in the format of the "grove" R package
  #Wavelet transform of the dat


  W <- grove::DWT(Y)

  Y_f <- cbind(W$C, W$D) #Using a column like phenotype

  #Data to fit mash
  Bhat  <- list()
  Shat  <- list()

  #Fitting the effect variable by variable
  for (  i in 1: dim(G)[2])
  {
    #Fitting the effect wavelet coeff by wavelet coeff
    temp_Bhat <- c()
    temp_Shat <- c()
    for ( l in 1:dim(Y_f)[2])
    {
      temp <- lm(Y_f[,l]~ G[,i])
      temp_Bhat <- c(temp_Bhat, summary(temp)$coefficients[2,1])
      temp_Shat <- c(temp_Shat, summary(temp)$coefficients[2,2])
    }
    Bhat[[i]] <- temp_Bhat
    Shat[[i]] <- temp_Shat
  }

  Bhat <- (do.call(rbind, Bhat))
  Shat <- (do.call(rbind, Shat))


  if( is.flash)
  {
    wave_flash <- flash(Bhat/Shat,verbose=FALSE)

  }

  #######################################
  #Creating additionnal mixture component
  #######################################

  if( gen_cov & !(is.flash))
  {
    list_cov <- gen_cov_wav(lev_res = lev_res)


  }
  if(!(gen_cov)& is.flash)
  {
    list_cov <- list()
    for ( i in 1:dim(wave_flash$fit$EF)[2])
    {
      list_cov[[i]] <- wave_flash$fit$EF[,i]%*%t(wave_flash$fit$EF[,i])
    }
  }
  if((gen_cov)& is.flash)
  {
    list_cov <- gen_cov_wav(lev_res = lev_res)
    temp_list_length <- length(length(list_cov))
    for ( i in 1:dim(wave_flash$fit$EF)[2])
    {

      list_cov[[(temp_list_length+i)]] <- wave_flash$fit$EF[,i]%*%t(wave_flash$fit$EF[,i])
    }
  }
  #############
  #Fitting mash
  #############

  if( !gen_cov &! is.flash)
  {
    m_init <- mmbr::create_mash_prior(sample_data = list(X=G,Y=Y_f,
                                                         residual_variance=cov(Y_f)),
                                      max_mixture_len=-1)

    cov_Y <- diag(1,ncol = m,nrow = m)
    m1 <- mmbr::msusie(X=G,
                       Y=Y_f,
                       L=2,
                       prior_variance=m_init,
                       residual_variance=cov_Y,
                       estimate_residual_variance=T,
                       estimate_prior_variance=T,
                       estimate_prior_method='simple',
                       compute_objective=F,
                       precompute_covariances=TRUE,
                       track_fit=TRUE
    )
  }else{

    m_init <- mmbr::create_mash_prior(mixture_prior=list(matrices=list_cov ),
                                       max_mixture_len=length(list_cov))
    cov_Y <- diag(1,ncol = m,nrow = m)
    m1 <- mmbr::msusie(X=G,
                       Y=Y_f,
                       L=2,
                       prior_variance=m_init,
                       residual_variance=cov_Y,
                       estimate_residual_variance=T,
                       estimate_prior_variance=T,
                       estimate_prior_method='simple',
                       compute_objective=F,
                       precompute_covariances=TRUE,
                       track_fit=TRUE
    )

  }


  pred <- predict.mmbr(m1, G)

  ###########################
  #Computing fitted functions
  ###########################
  temp <- wavethresh:: wd(rep(1, m))
  fitted_func <- matrix(NA, ncol = m, nrow = N) #individual  function


  for (i in 1:N)
  {
    temp$D <- rev(pred[i,-1])
    temp$C[length(temp$C)] <- pred[i,1]
    fitted_func [i, ] <- wavethresh:::wr(temp)
  }


  pip <- m1$pip
  if(  plot_out ==TRUE)
  {
    par(mfrow=c(1,2))
    plot(  pip , main="PiP value for each covariate \n MSusie ",
           xlab = "Variable",
           col=my_col_pos,
           pch=16)
    plot( fitted_func[1,],
          col= "black",
          type ="l",
          ylim=c(4*min(fitted_func),4*max(fitted_func)),
          lwd=1.5,
          ylab="y",
          xlab="time",
          main=paste( "Fitted curves, number of  effect ",L,"\n using MSusie")
    )
    for ( i  in 2: N)
    {
      if( G[i, 1]==0  & G[i,2]==0)
      {
        my_col <- "black"
      }

      if( G[i, 1]==1  & G[i,2]==0)
      {
        my_col <- "red"
      }
      if( G[i, 1]==0  & G[i,2]==1)
      {
        my_col <- "green"
      }
      if( G[i, 1]==1  & G[i,2]==1)
      {
        my_col <- "blue"
      }

      lines( fitted_func[i,], col=   my_col,lwd=1.5)
    }

    legend(title= "Objective",x=m*0.1, y=4*max(fitted_func), c("baseline", "variant 1", "variant 2", "variant 1 & 2"),
           col = c("black","red","green","blue") ,
           lty = rep(2,3),
           lwd= rep(2,3), box.lty=0)

    par(mfrow=c(1,1))

  }

  out <- list( fitted_func = fitted_func,
               pip         = pip,
               m_susie     = m1

  )
}

