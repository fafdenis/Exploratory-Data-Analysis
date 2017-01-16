---------------------------
# This file does the following:
# 1. Reads in the full data set (2,075,259 rows and 9 columns).
# 2. Keeps only observations for 2007-02-01 and 2007-02-02.
# 3. Converts Date and Time variables.
# 4. Plots multivariate line graph.
# 5. Saves plot as PNG file, height: 480 pixels and width: 480 pixels.
---------------------------
	
# Read in full dataset 
data <- read.csv("./data/household_power_consumption.txt", sep = ";", header = TRUE,
		 na.strings = "?", nrows = 2075259, check.names = F, stringsAsFactors = F, 
		 comment.char = "", quote = '\"')
	
# Keep observations for 2007-02-01 and 2007-02-02
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
	
# Create new variable combining date and time
datetime <- paste(as.Date(data$Date), data$Time)
data$datetime <- as.POSIXct(datetime)
	
# Plot 3: Multivariate line plot
with(data, {
	plot(Sub_metering_1 ~ datetime, type = "l", 
	     ylab = "Global Active Power (kilowatts)", xlab = "")
	lines(Sub_metering_2 ~ datetime, col = "red")
	lines(Sub_metering_3 ~ datetime, col = "blue")
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save as PNG file
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()