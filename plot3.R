##
## plot3.R
## Ferdinand DeRamos
## 2015-05-10

## Load the dataset from the text file located in the directory called exploratory_data_analysis.
## The said text file, excluding the header, has 2075259 observations.

household_power_consumption <- read.csv(file = "exploratory_data_analysis/household_power_consumption.txt", 
                                        header = TRUE, sep = ';', na.strings = "?", nrows = 2075259, 
                                        check.names = FALSE, stringsAsFactors = FALSE, comment.char = "", 
                                        quote = '\"')

## Make sure the Date variable is of Date format.
household_power_consumption$Date <- as.Date(household_power_consumption$Date, format = "%d/%m/%Y")

## We will only be using data from the dates 2007-02-01 and 2007-02-02.
household_power_consumption_2days <- subset(household_power_consumption, 
                                            subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Create combined Date and Time variable.
household_power_consumption_2days$Datetime <- as.POSIXct(paste(household_power_consumption_2days$Date, household_power_consumption_2days$Time),
                                                         format = "%Y-%m-%d %H:%M:%S")

## Remove household_power_consumption.
rm(household_power_consumption)

## Construct Plot 3 and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
with(household_power_consumption_2days, {
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save the diagram as png file.
dev.copy(png, file="exploratory_data_analysis/plot3.png", height = 480, width = 480)
dev.off()

## Remove household_power_consumption_2days.
rm(household_power_consumption_2days)
