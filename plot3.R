#if sqldf is not already installed
install.packages("sqldf")

#load data
library(sqldf)
workset <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";",
                        sql="Select * from file where Date = '1/2/2007' 
                        OR Date = '2/2/2007'")
closeAllConnections()
#merge date in time into one column
workset$datetime <- paste(workset$Date, workset$Time, sep=";")
#convert datetime column to POSIXlt
workset$datetime <- strptime(workset$datetime, format="%d/%m/%Y;%T")

#construct plot3
#create PNG
png(filename="plot3.png", width=480, height=480, units="px", bg="transparent")
#make empty plot with datetime on x axis and Sub_metering_1 on y axis
plot(workset$datetime, workset$Sub_metering_1, type="n", xlab="", 
     ylab="Energy sub metering")
#add lines for the three Sub_metering variables
lines(workset$datetime, workset$Sub_metering_1, col="black")
lines(workset$datetime, workset$Sub_metering_2, col="red")
lines(workset$datetime, workset$Sub_metering_3, col="blue")
#create legend
legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), col=c("black","red","blue"))
dev.off()