library(data.table) # data.table is much faster than read.table for read large data files
library(dplyr)

## data file transaction
  # Read date file with missing value is equal "?"
  hpcTbl<- fread("household_power_consumption.txt", na.strings = "?")

  # Create a data frame tbl
  hbc_df <- tbl_df(hpcTbl) 

  #subset plotting data
  plot_df <- subset(hpc_df, Date == "1/2/2007" | Date == "2/2/2007")


## making plot and save with png graphic devices
  # open png graphic device
  png("plot1.png", width = 480, height = 480, units = "px")

  # Create Histogram
  with(plot_df, hist(Global_active_power, xlab="Global Active Power (kilowatts)", main = "Global Active Power", col ="red"))

  # save to png graphic device
  dev.off()