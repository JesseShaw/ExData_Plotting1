##This script will ingest raw data and generate PLOT 3

## Load required libraries
require("lubridate")
require("sqldf")

#Set working directory
wd <- getwd()

##STEP1 - Get Data and subset it
fname <- "household_power_consumption.txt"
fn <- file.path(wd,fname)
hpc <- read.csv.sql(fn, sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"', header = TRUE, sep =";")

##STEP2 - Isolate Data
gap <- as.numeric(hpc$Global_active_power)
dat <- strptime(paste(hpc$Date, hpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
sm1 <- as.numeric(hpc$Sub_metering_1)
sm2 <- as.numeric(hpc$Sub_metering_2)
sm3 <- as.numeric(hpc$Sub_metering_3)
grp <- as.numeric(hpc$Global_reactive_power)
volts <- as.numeric(hpc$Voltage)

##STEP3 - Plot Data
png("plot4.png", width=504, height=504)
par(mfrow = c(2, 2))

#Plot1
plot(dat, gap, type="l", xlab="", ylab="Global Active Power (KW)")

#Plot2
plot(dat, volts, type="l", xlab="datetime", ylab="Voltage")

#Plot3
plot(dat, sm1, type="l", ylab="Energy Sub Metering", xlab="")
lines(dat, sm2, type="l", col="red")
lines(dat, sm3, type="l", col="blue")
legend("topright", c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

#Plot4
plot(dat, grp, type="l", xlab="datetime", ylab="Global Reactive Power")

##STEP4 - Close Quartz
dev.off()