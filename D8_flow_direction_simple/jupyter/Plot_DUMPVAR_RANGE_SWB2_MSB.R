swb2_dir <- "~/SMWData/swb2_report/swb_examples/D8_toy/"

setwd( swb2_dir )

swb2_filename <- paste( swb2_dir, "SWB2_variable_values__start_index_1__end_index_25.csv", sep="" )

swb2 <- read.csv( swb2_filename )

swb2$date <- lubridate::mdy( paste( swb2$month, swb2$day, swb2$year,sep="-") )
swb2$deficit <- swb2$soil_storage_max - swb2$soil_storage

swb2 <- subset(swb2,date <= lubridate::mdy("09/03/2012") )

pdf( file="mass_balance_errors.pdf", width = 11, height=8.5 )
par( mfrow=c(5,5) )

for (mydate in seq.Date(from=lubridate::mdy("04/01/2012"),to=lubridate::mdy("05/31/2012"),by="days")) {

for (indx in seq(1,max( swb2$solution_order )) ) {

  swb2_ss <- subset(swb2, cell_index == indx )
  nrow <- nrow( swb2_ss )

  swb2_ss <- subset(swb2_ss, date == mydate )

  swb2_ss$msb <- with(swb2_ss, rainfall + snowmelt + irrigation - interception + runon - runoff - actual_ET
                      - net_infiltration - rejected_net_infiltration + delta_soil_storage )

  values <- with( swb2_ss, c( rainfall, snowmelt, irrigation, runon, runoff, actual_ET, net_infiltration,
                              rejected_net_infiltration, delta_soil_storage, msb))

  values <- values * c(1,1,1,1,-1,-1,-1,-1,1,1)
  labs <- c("ra","sn","ir","ron","rof","aet","ni",
            "rni","sd","msb")

  swb2names <- names(swb2_ss)

  if ( abs(swb2_ss$msb) > 1.0e-5 ) {
    col="red"
  } else {
    col="grey"
  }

  barplot( height=values, names.arg=labs, cex.names=0.5, col=col )

  title(paste(swb2_ss$month[1],"/",swb2_ss$day[1],"/",swb2_ss$year[1],": \ncell_index=",unique(swb2_ss$cell_index),
              " solution_order=",unique(swb2_ss$solution_order),"\n",
              " tgt_indx=",unique(swb2_ss$target_index ),
              " u/s cells=",unique(swb2_ss$sum_upslope_cells)),
        cex.main=0.65)

}

}

dev.off()
