swb2_dir <- "~/SMWData/swb2_report/swb_examples/D8_toy/"

setwd( swb2_dir )

swb2_filename <- paste( swb2_dir, "SWB2_variable_values__start_index_1__end_index_25.csv", sep="" )

swb2 <- read.csv( swb2_filename )

swb2$date <- lubridate::mdy( paste( swb2$month, swb2$day, swb2$year,sep="-") )
swb2$deficit <- swb2$soil_storage_max - swb2$soil_storage

swb2 <- subset(swb2, date <= lubridate::mdy("09/01/2012") )

pdf( file="mass_balance_errors.pdf", width = 11, height=8.5 )
par( mfrow=c(5,5) )

for (indx in seq(1,max( swb2$sort_order )) ) {

  swb2_ss <- subset(swb2, sort_order == indx )
  nrow <- nrow( swb2_ss )
  swb2_ss$soil_delta <- rep(0.0, nrow )
  swb2_ss$soil_delta[2:nrow] <- swb2_ss$soil_storage[1:nrow-1] - swb2_ss$soil_storage[2:nrow]

  swb2_ss$msb <- with(swb2_ss, rainfall + snowmelt + irrigation - interception + runon - runoff - actual_ET - net_infiltration - rejected_recharge + soil_delta )
  swb2_ss$msb[1]<- 0.0

  swb2names <- names(swb2_ss)

  for (var in c('msb') ) {
    print (var)

    y <- swb2_ss[[var]]
    plot(swb2_ss$date, y, cex=0.5, col="black", pch=21, xlab="", ylab="error in inches" )
    lines(swb2_ss$date, y, col="blue")
    # points( swb2$date, swb2$deficit, col="black", cex=0.75, pch=21 )
    # lines( swb2$date, swb2$deficit, col="black", lty=2 )
    # points( swb1$date, swb1$deficit, col="blue", cex=0.55, pch=23 )
    # lines( swb1$date, swb1$deficit, col="blue", lty=2 )
    #points( swb2$date, swb2$rainfall, col="cyan", pch=20, cex=0.5 )
    #lines( swb2$date, swb2$rainfall, col="cyan")
    abline( h=0, col="red")
    title(paste(var,": sort_order=",unique(swb2_ss$sort_order),
                " cel_indx=",unique(swb2_ss$cell_index),
                " tgt_indx=",unique(swb2_ss$target_index ),
                " u/s cells=",unique(swb2_ss$sum_upslope_cells)),
          cex.main=0.65)

  }

}

dev.off()
