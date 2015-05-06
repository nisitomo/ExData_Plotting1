rm(list=ls())

library(dplyr)

filename <- "household_power_consumption.txt"

# Read the data file
# data_HouseholdPower_Consumption <- read.table(filename, sep = ";", colClasses = c(rep("character", 2), rep("numeric", 7)))
data_HouseholdPower_Consumption <- read.table(filename, header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Replace '?' to NA value
data_HouseholdPower_Consumption[data_HouseholdPower_Consumption[] == "?"] <- NA

data_HouseholdPower_Consumption <- data_HouseholdPower_Consumption %>%
  mutate(Global_active_power = as.numeric(Global_active_power)) %>%
  mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
  mutate(Voltage = as.numeric(Voltage)) %>%
  mutate(Global_intensity = as.numeric(Global_intensity)) %>%
  mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
  mutate(DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

# limit to the necessary records
data_HouseholdPower_Consumption <- data_HouseholdPower_Consumption %>%
  filter(DateTime >= as.POSIXct("2007-02-01", format = "%Y-%m-%d") & DateTime < as.POSIXct("2007-02-03", format = "%Y-%m-%d"))

# Create plot on screen device
hist(data_HouseholdPower_Consumption$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Copy the plot from display device to PNG file
dev.copy(png, file = "plot1.png")
dev.off()
