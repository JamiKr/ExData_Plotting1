download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'power-consumption.zip')
unzip('power-consumption.zip')
raw <- read.table('household_power_consumption.txt', header = TRUE, 
	sep = ';', stringsAsFactors = FALSE, na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# We will only be using data from the dates 2007-02-01 and 2007-02-02
data <- subset(raw, Date %in% c('1/2/2007', '2/2/2007'))
transform(data, Date = as.Date(Date, format = "%d/%m/%Y"))
transform(data, Time = strptime(Time, format = "%H:%M:%S"))
data <- transform(data, DateTime = as.POSIXct(paste(Date, Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))

plot.new()
par(mfrow = c(2, 2))
png("plot4.png", width = 480, height = 480, bg = "transparent")
dev.set(2)

# top left
plot(data$DateTime, data$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n")
lines(data$DateTime, data$Global_active_power)

# top right
plot(data$DateTime, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(data$DateTime, data$Voltage)

# bottom left
plot(data$DateTime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(data$DateTime, data$Sub_metering_1, col = "black")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(rep("solid", 3)), box.lwd = 0)

# bottom right
plot(data$DateTime, data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
lines(data$DateTime, data$Global_reactive_power)

dev.copy(which = 4)
dev.off()