# data.table is much faster than read.table for read large data files
library(data.table) 
library(dplyr)
library(lubridate)
## data file transaction
  # Read date file with missing value is equal "?"
  hpcTbl<- fread("household_power_consumption.txt", na.strings = "?")

  # Create a data frame tbl
  hbc_df <- tbl_df(hpcTbl) 

  #subset plotting data
  plot_df <- subset(hpc_df, Date == "1/2/2007" | Date == "2/2/2007")
  
  #change Date format to %Y-%m-%d
  plot_df_with_datetime <- mutate(plot_df, Date = as.Date(parse_date_time(plot_df$Date,"dmy")))
  #add datetime column to paste with Date, Time column
  plot_df_with_datetime <- mutate(plot_df_with_datetime, datetime = strftime(paste(plot_df_with_datetime$Date,plot_df_with_datetime$Time),"%Y-%m-%d %H:%M:%S"))
  
 ## making plot and save with png graphic devices
  # open png graphic device
  png("plot2.png", width = 480, height = 480, units = "px")
  
  # Create plot
  with(plot_df_with_WkDays, plot(as.POSIXlt(datetime), Global_active_power, type="l", ylab="Global ActivePower (kilowatts)", xlab=""))
  
  # save to png graphic device
  dev.off()