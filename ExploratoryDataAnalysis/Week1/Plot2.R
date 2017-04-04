setwd("C:/Users/brcopela/Documents/R/Work/Week1")
library(readr)
library(ggplot2)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
df <- read_delim(unz(temp, "household_power_consumption.txt"), ";", escape_double = FALSE, trim_ws = TRUE)
unlink(temp)
rm(temp)

df <- subset(df, (Date == "2/1/2007" | Date == "2/2/2007"))
df$Date <- mdy(df$Date)
df$Timestamp <- with(df, as.POSIXct(paste(Date, Time)))

dev.off()
dev.new("RStudioGD")

plot(df$Timestamp, df$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, file = "Plot2.png")

dev.off()

