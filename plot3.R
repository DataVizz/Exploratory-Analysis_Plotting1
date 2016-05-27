## Getting data
power = read.table("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

## Subsetting the data
powersub <- subset(power, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(power)

## Converting dates
DateTime <- paste(as.Date(powersub$Date), powersub$Time)
powersub$DateTime <- as.POSIXct(DateTime)

## Plot 3
with(powersub, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()