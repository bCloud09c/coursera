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
df_gather <- gather(df, key = "ReadingType", value = "Value", 7:9)  
View(df_gather)

dev.off()
dev.new("RStudioGD")

par(mfrow = c(2,2))
with(df, {
  plot(Timestamp, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  plot(Timestamp, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  
  with(df_gather, plot(Timestamp, Value, ylab = "Energy Sub Metering", xlab = "", type = "n", ylim=c(0,30)))
  with(subset(df_gather, ReadingType == "Sub_metering_1"), lines(Timestamp, Value, col = "Black"))
  with(subset(df_gather, ReadingType == "Sub_metering_2"), lines(Timestamp, Value, col = "Red"))
  with(subset(df_gather, ReadingType == "Sub_metering_3"), lines(Timestamp, Value, col = "Blue"))
  legend("topright", lty = 1, cex = .8, pt.cex = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Timestamp, Global_reactive_power, type = "l", ylab = "Global Reactive Power", xlab = "datetime")
  
})

dev.copy(png, file = "Plot4.png")

dev.off()
