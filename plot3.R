################################# plot3.R #################################
## This piece of code generates a time series plot from the given        ##
## household power dataset within the time period 01/02/2007 and         ##
## 02/02/2007. The plot is saved in a 'png' R device called 'plot3.png'  ##
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
## getting 'Sub metering' data as numeric components ##
subMetering1 <- as.numeric(as.character(powerData$Sub_metering_1))
subMetering2 <- as.numeric(as.character(powerData$Sub_metering_2))
subMetering3 <- as.numeric(as.character(powerData$Sub_metering_3))
## openning png plotting device with required dimensions ##
png("plot3.png", height = 480, width = 480)
## plotting lineplots for the 3 sub meter data differentiable by color ##
plot(timeSeries, subMetering1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(timeSeries, subMetering2, col = "red")
lines(timeSeries, subMetering3, col = "blue")
## putting legend for the plot for better identification of plots ##
legend("topright", col = c("black", "red", "blue"),
	   legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
	   lty = 1)
## closing off the plotting device ##
dev.off()