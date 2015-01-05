##This script will ingest raw data and generate PLOT 1

## Load required libraries
require("lubridate")
require("sqldf")

#Set working directory
wd <- getwd()

##STEP1 - Get Data and subset it
fname <- "household_power_consumption.txt"
fn <- file.path(wd,fname)
hpc <- read.csv.sql(fn, sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"', header = TRUE, sep =";")
hpc$Date <- strptime(hpc$Date, "%d/%m/%Y")
hpc$Time <- strptime(hpc$Time, format= '%H:%M:%S')
hpc$Time <- strftime(hpc$Time, '%H:%M:%S')
hpc <- hpc[order(hpc$Date, hpc$Time),]

##STEP2 - Plot Data
gap <- as.numeric(hpc$Global_active_power)
png("plot1.png", width=480, height=480)
hist(gap, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

##STEP3 - Close Quartz
dev.off()