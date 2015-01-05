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

##STEP2 - Plot Data
gap <- as.numeric(hpc$Global_active_power)
dat <- strptime(paste(hpc$Date, hpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
sm1 <- as.numeric(hpc$Sub_metering_1)
sm2 <- as.numeric(hpc$Sub_metering_2)
sm3 <- as.numeric(hpc$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(dat, sm1, type="l", ylab="Energy Sub Metering", xlab="")
lines(dat, sm2, type="l", col="red")
lines(dat, sm3, type="l", col="blue")
legend("topright", c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

##STEP3 - Close Quartz
dev.off()