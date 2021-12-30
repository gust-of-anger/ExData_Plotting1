library(lubridate)

power <- read.table("household_power_consumption.txt", header = TRUE, sep=';')

#Transforming the date column to date type
power$Date <- as.Date(power$Date, "%d/%m/%Y")

# Defining the initial and final dates
date_1 <- as.Date("2007/02/01", "%Y/%m/%d")
date_2 <- as.Date("2007/02/02", "%Y/%m/%d")

# Subsetting to the desired date range
two_days <- subset(power, power$Date >= date_1 & power$Date <= date_2)

# Transforming the Global active power column do numeric type
two_days$Global_active_power <- as.double(two_days$Global_active_power)

# Defining a new column with the complete datetime
two_days$complete_date <- ymd_hms(paste(as.character(two_days$Date),two_days$Time, sep = " "))

# Transforming the sub metering columns to numeric type
two_days$Sub_metering_1 <- as.double(two_days$Sub_metering_1)
two_days$Sub_metering_2 <- as.double(two_days$Sub_metering_2)
two_days$Sub_metering_3 <- as.double(two_days$Sub_metering_3)

# Plotting a line plot into a png file and adding the new plots as necessary
png("plot4.png", width = 480, height = 480)

# Creating a 2 x 2 plot
par(mfrow=c(2,2))

#Top left plot
plot(two_days$complete_date, two_days$Global_active_power, type="l", xlab = " ", ylab = "Global Active Power (kilowatts)")

# Top right plot
plot(two_days$complete_date, two_days$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

# Bottom left plot
plot(two_days$complete_date, two_days$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(two_days$complete_date, two_days$Sub_metering_2, type="l", col = "red")
lines(two_days$complete_date, two_days$Sub_metering_3, type="l", col = "blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), bty="n")

# Bottom right plot
plot(two_days$complete_date, two_days$Global_reactive_power, type = "l", xlab = "datetime", ylab="Global_reactive_power")
dev.off()