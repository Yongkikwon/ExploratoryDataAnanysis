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

  # Create plot
  # open png graphic device
  #  dev.copy(png,filename="plot4.png");
  png("plot4.png", width = 480, height = 480)
  
  # Set to Create a 4 multi-paneled plotting 
  par(mfrow=c(2,2))

  # create plot in (1,1) 
  with(plot_df_with_datetime, plot(as.POSIXlt(datetime), Global_active_power, type="l", ylab="Global ActivePower (kilowatts)", xlab=""))

  # create plot in (1,2)
  with(plot_df_with_datetime, plot(as.POSIXlt(datetime), Voltage, type="l", ylab="Voltage", xlab="datetime"))

  # create plot in (2,1)
  with(plot_df_with_datetime, plot(as.POSIXlt(datetime), Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
  with(plot_df_with_datetime, points(as.POSIXlt(datetime), Sub_metering_2, type="l", col="red"))
  with(plot_df_with_datetime, points(as.POSIXlt(datetime), Sub_metering_3, type="l", col="blue"))
  with(plot_df_with_datetime, legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black", "red", "blue"), bty = "n", lty=1, cex=0.75))

  # create plot in (2,2)
  with(plot_df_with_datetime, plot(as.POSIXlt(datetime), Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))

# save to png graphic device
dev.off()