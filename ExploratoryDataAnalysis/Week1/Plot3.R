setwd("C:/Users/brcopela/Documents/R/Work/Week1")

library(readr)
library(ggplot2)
library(tidyr)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
df <- read_delim(unz(temp, "household_power_consumption.txt"), ";", escape_double = FALSE, trim_ws = TRUE)
unlink(temp)
rm(temp)

df <- subset(df, (Date == "2/1/2007" | Date == "2/2/2007"))
df$Date <- mdy(df$Date)
df$Timestamp <- with(df, as.POSIXct(paste(Date, Time)))
df <- df[c(7:10)]
df <- gather(df, key = "ReadingType", value = "Value", 1:3)  

dev.off()
dev.new("RStudioGD")

with(df, plot(Timestamp, Value, ylab = "Energy Sub Metering", xlab = "", type = "n", ylim=c(0,25)))
with(subset(df, ReadingType == "Sub_metering_1"), lines(Timestamp, Value, col = "Black"))
with(subset(df, ReadingType == "Sub_metering_2"), lines(Timestamp, Value, col = "Red"))
with(subset(df, ReadingType == "Sub_metering_3"), lines(Timestamp, Value, col = "Blue"))
legend("topright", lty = 1, cex = .7, pt.cex = 1.2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "Plot3.png")

dev.off()
