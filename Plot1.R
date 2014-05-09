##download zip file, save txt file in working directory
zipFile <- "household_power_consumption.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile=zipFile, method="curl")
unzip(zipFile)
file.remove(zipFile)

##read in data, subset by date
data <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
sub_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
rm(data)

##create plot
hist(sub_data$Global_active_power, 
     ylim = c(0,1200), ylab = "Frequency", 
     xlim = c(0,6), xlab = "Global Active Power (kilowatts)",
     col = "red", main = "Global Active Power")

##save to working directory
dev.copy(png,'Plot1.png')
dev.off()
