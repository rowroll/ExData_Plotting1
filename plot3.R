## Exploratory Data Analysis on Coursera
## Course Project 1, Deadline 11 October 2015
## Plot 3

library(downloader)

# The base directory.
dirName <- "exdata-data-household_power_consumption"

# Check if the base directory exists, if not, download the zipped data and unzip
if (!file.exists(dirName)) {
  # Link to data
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  # Download the file using downloader package
  download(fileUrl, dest="dataset.zip", mode="wb") 
  # Unzip to folder
  unzip ("dataset.zip", exdir = dirName)
}

# Path to data
dataFile <- paste(dirName, "/household_power_consumption.txt", sep="")

# Read in the header
header <- read.table(dataFile, header=FALSE, sep=";",  nrows=1)

# Read in the data from the dates 2007-02-01 and 2007-02-02, skip found using trial
# and error.  Add header and print to screen just to be sure.
data <- read.table(dataFile, header=FALSE, sep=";", skip=66637, nrows=24*60*2)
colnames(data) <- unlist(header)
head(data)
tail(data)

# Set the locale display dates in English
Sys.setlocale("LC_TIME", "C");

# Change the date and time information into a form R understands
data$dateCol <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Print to png file
png(filename="plot3.png",width = 480, height = 480, units = "px", pointsize = 12, bg = "transparent")

# Plot to device
with(data, plot(dateCol, Sub_metering_1, type="l",col="black", xlab="", ylab="Energy sub metering"))
points(data$dateCol, data$Sub_metering_2, type="l", col="red")
points(data$dateCol, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

# Close the png device
dev.off()
