rm(list=ls())

library(dplyr)

# prepare environment
tmp_LC_TIME <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

# parameter
filename <- "household_power_consumption.txt"
filename_png <- "plot4.png"

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
# par(mfrow = c(2,2))
# # plot1
# with(data_HouseholdPower_Consumption, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
# # plot2
# with(data_HouseholdPower_Consumption, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
# # plot 3
# with(data_HouseholdPower_Consumption, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
# with(data_HouseholdPower_Consumption, lines(DateTime, Sub_metering_1))
# with(data_HouseholdPower_Consumption, lines(DateTime, Sub_metering_2, col = "red"))
# with(data_HouseholdPower_Consumption, lines(DateTime, Sub_metering_3, col = "blue"))
# legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 1, bty = "n")
# # plot4
# with(data_HouseholdPower_Consumption, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

# Create plot to PNG file
png(file = filename_png, width=480, height=480)
par(mfrow = c(2,2))
# plot1
with(data_HouseholdPower_Consumption, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
# plot2
with(data_HouseholdPower_Consumption, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
# plot 3
with(data_HouseholdPower_Consumption, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(data_HouseholdPower_Consumption, lines(DateTime, Sub_metering_1))
with(data_HouseholdPower_Consumption, lines(DateTime, Sub_metering_2, col = "red"))
with(data_HouseholdPower_Consumption, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 1, bty = "n")
# plot4
with(data_HouseholdPower_Consumption, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()


# set back environment
Sys.setlocale("LC_TIME", tmp_LC_TIME)
