swb2_dir <- "~/SMWData/swb2_report/swb_examples/D8_toy/"

swb2_filename <- paste( swb2_dir, "SWB2_variable_values__start_index_1__end_index_25.csv", sep="" )

swb2 <- read.csv( swb2_filename )

swb2$date <- lubridate::mdy( paste( swb2$month, swb2$day, swb2$year,sep="-") )
swb2$deficit <- swb2$soil_storage_max - swb2$soil_storage

swb2 <- subset(swb2, date <= lubridate::mdy("09/01/2012") )
swb2 <- subset(swb2, natural_index == 25 )

nrow <- nrow( swb2 )
swb2$soil_delta <- rep(0.0, nrow )
swb2$soil_delta[2:nrow] <- swb2$soil_storage[1:nrow-1] - swb2$soil_storage[2:nrow]

swb2$msb <- with(swb2, rainfall + snowmelt + irrigation - interception + runon - runoff - actual_ET - net_infiltration - rejected_recharge + soil_delta )

swb2names <- names(swb2)

for (n in seq(6,length(swb2names))) {
    print (swb2names[n])

  y <- swb2[[swb2names[n]]]
  plot(swb2$date, y, cex=0.5, col="black", pch=21 )
  lines(swb2$date, y, col="black")
  # points( swb2$date, swb2$deficit, col="black", cex=0.75, pch=21 )
  # lines( swb2$date, swb2$deficit, col="black", lty=2 )
  # points( swb1$date, swb1$deficit, col="blue", cex=0.55, pch=23 )
  # lines( swb1$date, swb1$deficit, col="blue", lty=2 )
  #points( swb2$date, swb2$rainfall, col="cyan", pch=20, cex=0.5 )
  #lines( swb2$date, swb2$rainfall, col="cyan")
  title(swb2names[n])

}

