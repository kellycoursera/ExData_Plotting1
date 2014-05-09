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
plot(sub_data$Time, sub_data$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power (kilowatts)", ylim = c(0,6),
     xlab = "")

##save to working directory
dev.copy(png,'Plot2.png')
dev.off()
