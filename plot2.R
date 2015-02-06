#if sqldf is not already installed
install.packages("sqldf")

#load data and convert date and time
library(sqldf)
workset <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";",
                        sql="Select * from file where Date = '1/2/2007' 
                        OR Date = '2/2/2007'")
workset$datetime <- paste(workset$Date, workset$Time, sep=";")
workset$datetime <- strptime(workset$datetime, format="%d/%m/%Y;%T")

#construct plot2
png(filename="plot2.png", width=480, height=480, units="px", bg="transparent")
plot(workset$datetime, workset$Global_active_power, type="n", xlab="", 
     ylab="Global Active Power (kilowatts)")
lines(workset$datetime, workset$Global_active_power)
dev.off()