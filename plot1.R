---------------------------
# This file does the following:
# 1. Reads in the full data set (2,075,259 rows and 9 columns).
# 2. Keeps only observations for 2007-02-01 and 2007-02-02.
# 3. Converts Date and Time variables.
# 4. Plots histogram for "Global Active Power".
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

# Plot 1: Histogram of Global Active Power
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")

# Save as PNG file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()