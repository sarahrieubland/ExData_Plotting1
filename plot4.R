### Exploratory Analysis CLASS ###
### Week 1: Course Project 1
### Code for plot 4

library(downloader)
setwd("/Users/srieubland/Documents/Documents/DataScience/04_Exploratory/CourseProject1")

## Downloard and unzip the data

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download(fileUrl,dest="Electric_power_consumption.zip", mode = "wd") 
unzip ("Electric_power_consumption.zip",exdir = "./")
dateDownloaded <- date()

## Open data file
data_energy <- read.table("household_power_consumption.txt", sep = ";", 
                          header = TRUE, quote = "", na.strings = "?",
                          stringsAsFactors = FALSE)

## Remove empty data
data_nona <- data_energy[!is.na(data_energy$Global_active_power),] 

## Convert times and select data
data_nona$NewTime <- strptime(paste(data_nona$Date, data_nona$Time, sep = " "), 
                              format = "%d/%m/%Y %H:%M:%S")
data_nona$NewDate <- strptime(data_nona$Date, format = "%d/%m/%Y")

start <- strptime("2007-02-01", format = "%Y-%m-%d")
end <- strptime("2007-02-02", format = "%Y-%m-%d")
data_use <- data_nona[data_nona$NewDate == start | data_nona$NewDate == end,]

## PLot 4
par(mfrow = c(2,2))
par(mar = c(4,4,2,2))
with(data_use, plot(NewTime, Global_active_power, type = "n", xlab = "",
                    ylab = "Global Active Power"))
lines(data_use$NewTime, data_use$Global_active_power)


with(data_use, plot(NewTime, Voltage, type = "n", xlab = "datetime",
                    ylab = "Voltage"))
lines(data_use$NewTime, data_use$Voltage)


with(data_use, plot(NewTime, Sub_metering_1, type = "n", xlab = "",
                    ylab = "Energy sub metering"))
lines(data_use$NewTime, data_use$Sub_metering_1)
lines(data_use$NewTime, data_use$Sub_metering_2, col = "red")
lines(data_use$NewTime, data_use$Sub_metering_3, col = "blue")
legend("topright", legend =  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), border = "white", 
       lty = 1, col=c("black","red","blue"))

with(data_use, plot(NewTime, Global_reactive_power, type = "n", xlab = "datetime",
                    ylab = "Global_reactive_power"))
lines(data_use$NewTime, data_use$Global_reactive_power)

dev.copy(png, file = "plot4.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!