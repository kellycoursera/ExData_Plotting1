##download zip file, save txt file in working directory
zipFile <- "household_power_consumption.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile=zipFile, method="curl")
unzip(zipFile)
file.remove(zipFile)

##read in data
data <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
sub_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
rm(data)
sub_data$Time <- paste(sub_data$Date, sub_data$Time)
sub_data$Time <- strptime(sub_data$Time, format = "%Y-%m-%d %H:%M:%S")

##create plot
png(filename="plot4.png",width=480,height=480)
par(mfcol = c(2, 2))
plot(sub_data$Time, sub_data$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power (kilowatts)", ylim = c(0,6),
     xlab = "")

plot(sub_data$Time, sub_data$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")

lines(sub_data$Time, sub_data$Sub_metering_2, col = "red")
lines(sub_data$Time, sub_data$Sub_metering_3, col = "blue")

legend("topright", lty = 1, lwd = 2, bty = "n",
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(sub_data$Time, sub_data$Voltage,
     type = "l", 
     ylab = "Voltage", xlab = "datetime")

plot(sub_data$Time, sub_data$Global_reactive_power,
     type = "l", 
     ylab = "Global_reactive_power", xlab = "datetime")
dev.off()