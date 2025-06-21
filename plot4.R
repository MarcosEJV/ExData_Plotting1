library(dplyr) #Package used to edit the table

table <- read.csv("./household_power_consumption.txt", sep = ";") #To read the table
table <- tbl_df(table)

targetdate1 <- table %>% filter(Date == "1/2/2007") #First day subset
targetdate2 <- table %>% filter(Date == "2/2/2007") #Second day subset
targetdates <- targetdate1 %>% rbind(targetdate2)   #Merging days

date <- targetdates$Date #Gets the date
time <- targetdates$Time #Gets the time
dateandtime <- paste(date, time) #Merges dates and time into a vector
targetdates$DateTime <- strptime(dateandtime, "%d/%m/%Y %H:%M:%S") #Adds dates and time as a column

png("plot4.png", width = 480, height = 480, units = "px") #Opens the png file

par(mfrow = c(2,2)) #Specifies plots organization

plot(targetdates$DateTime,targetdates$Global_active_power, type = "l", xlab = "", #Builds plot 1
     ylab = "Global Active Power (kilowatts)")

plot(targetdates$DateTime,targetdates$Voltage, type = "l", xlab = "DateTime", ylab = "Voltage") #Builds plot 2

with(targetdates, plot(targetdates$DateTime, targetdates$Sub_metering_1, #Builds plot 3
                       col = "black", type = "l", xlab = "", ylab = "Energy sub metering"))
lines(targetdates$DateTime, targetdates$Sub_metering_2, col = "red", type = "l")
lines(targetdates$DateTime, targetdates$Sub_metering_3, col = "blue", type = "l")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

plot(targetdates$DateTime,targetdates$Global_reactive_power, type = "l", xlab = "DateTime", #Builds plot 4
     ylab = "Global_reactive_power")

dev.off() #Closes the png file

par(mfrow = c(1,1)) #Returns the plotting to base condition
