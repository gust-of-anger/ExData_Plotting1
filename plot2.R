library(lubridate)

power <- read.table("household_power_consumption.txt", header = TRUE, sep=';')

#Transforming the date column to date type
power$Date <- as.Date(power$Date, "%d/%m/%Y")

# Defining the initial and final dates
date_1 <- as.Date("2007/02/01", "%Y/%m/%d")
date_2 <- as.Date("2007/02/02", "%Y/%m/%d")

# Subsetting to the desired date range
two_days <- subset(power, power$Date >= date_1 & power$Date <= date_2)

# Transforming the Global active power column to numeric type
two_days$Global_active_power <- as.double(two_days$Global_active_power)

# Defining a new column with the complete datetime
two_days$complete_date <- ymd_hms(paste(as.character(two_days$Date),two_days$Time, sep = " "))

# Plotting a line plot into a png file
png("plot2.png", width = 480, height = 480)
plot(two_days$complete_date, two_days$Global_active_power, type="l", xlab = " ", ylab = "Global Active Power (kilowatts)")
dev.off()