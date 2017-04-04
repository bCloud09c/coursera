setwd("C:/Users/brcopela/Documents/R/Work/Week1")

library(readr)
library(ggplot2)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
df <- read_delim(unz(temp, "household_power_consumption.txt"), ";", escape_double = FALSE, trim_ws = TRUE)
unlink(temp)
rm(temp)

df <- subset(df, (Date == "2/1/2007" | Date == "2/2/2007"))

dev.off()
dev.new("RStudioGD")

hist(df$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power", freq = TRUE, xlim=c(0,6))

dev.copy(png, file = "Plot1.png")

dev.off()

