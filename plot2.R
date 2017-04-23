################################# plot2.R #################################
## This piece of code generates a time series plot from the given        ##
## household power dataset within the time period 01/02/2007 and         ##
## 02/02/2007. The plot is saved in a 'png' R device called 'plot2.png'  ##
###########################################################################

## loading 'data.table' for using 'fread' function ##
library(data.table)
## reading the large dataset of power very fast with 'fread'##
## separator is set to ';' and NA is placed in place of '?' ##
data <- fread("household_power_consumption.txt", sep = ";",
			  header = TRUE, na.strings = "?")
## changing the type of 'Date' column from 'string' to 'date' type ##
data$Date <- as.Date(data$Date, "%d/%m/%Y")
## subsetting dataset for the time period 01/02/2007 and 02/02/2007 ## 
powerData <- data[(data$Date == "2007-02-01")|(data$Date == "2007-02-02"),]
## constructing time series variable by between period 01/02/2007 and 02/02/2007##
## by concatenating 'Date' and 'Time' and converting to POSIXlt time format     ##
timeSeries <- strptime(paste(powerData$Date, powerData$Time, " "),
					   format = "%Y-%m-%d %H:%M:%S")
## extracting global active power data and converting to nemeric type ##
globalActivePower <- as.numeric(as.character(powerData$Global_active_power))
## openning png plotting device with required dimensions ##
png("plot2.png", height = 480, width = 480)
## plotting the line graph for global active power ##
plot(timeSeries, globalActivePower, type = "l", xlab = " ",
	 ylab = "Global Active Power (kilowatts)")
## closing off the plotting device ##
dev.off()
