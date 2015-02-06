#if sqldf is not already installed
install.packages("sqldf")

#load data and convert date and time
library(sqldf)
workset <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";",
                        sql="Select * from file where Date = '1/2/2007' 
                     OR Date = '2/2/2007'")
workset$datetime <- paste(workset$Date, workset$Time, sep=";")
workset$datetime <- strptime(workset$datetime, format="%d/%m/%Y;%T")

#construct plot4
png(filename="plot4.png", width=480, height=480, units="px", bg="transparent")
par(mfrow=c(2,2))

#top left plot
plot(workset$datetime, workset$Global_active_power, type="n", xlab="", 
     ylab="Global Active Power")
lines(workset$datetime, workset$Global_active_power)

#top right plot
plot(workset$datetime, workset$Voltage, type="n", xlab="datetime", 
     ylab="Voltage")
lines(workset$datetime, workset$Voltage)

#bottom left plot
plot(workset$datetime, workset$Sub_metering_1, type="n", xlab="", 
     ylab="Energy sub metering")
lines(workset$datetime, workset$Sub_metering_1, col="black")
lines(workset$datetime, workset$Sub_metering_2, col="red")
lines(workset$datetime, workset$Sub_metering_3, col="blue")
legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), col=c("black","red","blue"), bty="n")

#bottom right plot
plot(workset$datetime, workset$Global_reactive_power, type="n", xlab="datetime", 
     ylab="Global_reactive_power")
lines(workset$datetime, workset$Global_reactive_power)

dev.off()