#if sqldf is not already installed
install.packages("sqldf")

#load data and convert date and time
library(sqldf)
workset <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";",
                     sql="Select * from file where Date = '1/2/2007' 
                     OR Date = '2/2/2007'")
workset$datetime <- paste(workset$Date, workset$Time, sep=";")
workset$datetime <- strptime(workset$datetime, format="%d/%m/%Y;%T")

#construct plot1
png(filename="plot1.png", width=480, height=480, units="px", bg="transparent")
hist(workset$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()