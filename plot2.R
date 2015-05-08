rm(list=ls())

library(dplyr)

# init environment
tmp_LC_TIME <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

# parameter
filename <- "household_power_consumption.txt"
filename_png <- "plot2.png"

# Read the data file
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

# # Create plot on screen device
# plot(data_HouseholdPower_Consumption$DateTime, data_HouseholdPower_Consumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
# 
# # Copy the plot from display device to PNG file
# dev.copy(png, file = filename_png)
# dev.off()

# Create plot to PNG file
png(file = filename_png, width=480, height=480)
plot(data_HouseholdPower_Consumption$DateTime, data_HouseholdPower_Consumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()


# set back environment
Sys.setlocale("LC_TIME", tmp_LC_TIME)
