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

#construct plot2
#create PNG
png(filename="plot2.png", width=480, height=480, units="px", bg="transparent")
#create empty plot with datetime on x axis and  Global_active_power on y axis
plot(workset$datetime, workset$Global_active_power, type="n", xlab="", 
     ylab="Global Active Power (kilowatts)")
#add lines
lines(workset$datetime, workset$Global_active_power)
dev.off()