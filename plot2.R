##This script will ingest raw data and generate PLOT 2

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
png("plot2.png", width=480, height=480)
plot(dat, gap, type="l", xlab="", ylab="Global Active Power (kilowatts)")

##STEP3 - Close Quartz
dev.off()