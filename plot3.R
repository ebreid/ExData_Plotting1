#if sqldf is not already installed
install.packages("sqldf")

#load data and convert date and time
library(sqldf)
workset <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";",
                        sql="Select * from file where Date = '1/2/2007' 
                     OR Date = '2/2/2007'")
workset$datetime <- paste(workset$Date, workset$Time, sep=";")
workset$datetime <- strptime(workset$datetime, format="%d/%m/%Y;%T")

#construct plot3
png(filename="plot3.png", width=480, height=480, units="px", bg="transparent")
plot(workset$datetime, workset$Sub_metering_1, type="n", xlab="", 
     ylab="Energy sub metering")
lines(workset$datetime, workset$Sub_metering_1, col="black")
lines(workset$datetime, workset$Sub_metering_2, col="red")
lines(workset$datetime, workset$Sub_metering_3, col="blue")
legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), col=c("black","red","blue"))
dev.off()