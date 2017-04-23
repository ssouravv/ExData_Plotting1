################################# plot4.R #################################
## This piece of code generates 4 time series plots from the given       ##
## household power dataset within the time period 01/02/2007 and         ##
## 02/02/2007. The plot is saved in a 'png' R device called 'plot4.png'  ##
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
## extracting Voltage data and converting to nemeric type ##
voltage <- as.numeric(as.character(powerData$Voltage))
## getting 'Sub metering' data as numeric components ##
subMetering1 <- as.numeric(as.character(powerData$Sub_metering_1))
subMetering2 <- as.numeric(as.character(powerData$Sub_metering_2))
subMetering3 <- as.numeric(as.character(powerData$Sub_metering_3))
## extracting global reactive power data and converting to nemeric type ##
globalReactivePower <- as.numeric(as.character(powerData$Global_reactive_power))
## openning png plotting device with required dimensions ##
png("plot4.png", height = 480, width = 480)
## ssetting 2 by 2 grids for plotting device ##
par(mfrow = c(2,2))
## plotting the line graph for global active power  in position (1, 1)##
plot(timeSeries, globalActivePower, type = "l", xlab = " ",
	 ylab = "Global Active Power (kilowatts)")
## plotting the line graph for global active power  in position (1, 2)##
plot(timeSeries, voltage, type = "l", xlab = "datetime",
	 ylab = "Voltage")
## plotting lineplots for the 3 sub meter data differentiable by color at (2, 1) ##
plot(timeSeries, subMetering1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(timeSeries, subMetering2, col = "red")
lines(timeSeries, subMetering3, col = "blue")
## putting legend for the plot for better identification of plots ##
## the border of the legend display box is removed using bty = 'n'##
legend("topright", col = c("black", "red", "blue"),
	   legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
	   lty = 1, bty = "n")
## plotting the line graph for global reactive power  in position (2, 2)##
plot(timeSeries, globalActivePower, type = "l", xlab = "datetime",
	 ylab = "Global_reactive_power")
## closing off the plotting device ##
dev.off()
