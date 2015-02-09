### Exploratory Analysis CLASS ###
### Week 1: Course Project 1
### Code for plot 2

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

## PLot 2

with(data_use, plot(NewTime, Global_active_power, type = "n", xlab = "",
                    ylab = "Global Active Power (kilowatts)"))
lines(data_use$NewTime, data_use$Global_active_power)
dev.copy(png, file = "plot2.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!
