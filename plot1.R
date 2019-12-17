download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'power-consumption.zip')
unzip('power-consumption.zip')
raw <- read.table('household_power_consumption.txt', header = TRUE, 
	sep = ';', stringsAsFactors = FALSE, na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# We will only be using data from the dates 2007-02-01 and 2007-02-02
data <- subset(raw, Date %in% c('1/2/2007', '2/2/2007'))
transform(data, Date = as.Date(Date, format = "%d/%m/%Y"))
transform(data, Time = strptime(Time, format = "%H:%M:%S"))

plot.new()
png("plot1.png", width = 480, height = 480, bg = "transparent")
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
