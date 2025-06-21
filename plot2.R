library(dplyr) #Package used to edit the table

table <- read.csv("./household_power_consumption.txt", sep = ";") #To read the table
table <- tbl_df(table)

targetdate1 <- table %>% filter(Date == "1/2/2007") #First day subset
targetdate2 <- table %>% filter(Date == "2/2/2007") #Second day subset
targetdates <- targetdate1 %>% rbind(targetdate2)   #Merging days

date <- targetdates$Date #Gets date
time <- targetdates$Time #Gets time
dateandtime <- paste(date, time) #Paste dates and time into a vector
targetdates$DateTime <- strptime(dateandtime, "%d/%m/%Y %H:%M:%S") #Builds a new time column to the table
 
png("plot2.png", width = 480, height = 480, units = "px") #Opens the png file
plot(targetdates$DateTime,targetdates$Global_active_power, type = "l", xlab = "", #Builds the graph
     ylab = "Global Active Power (kilowatts)", xaxt = "n") #Deletes the x-axis
axis(side = 1, at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", #Adds 2007-02-01, 2007-02-02 00:00:00 and 2007-02-02 23:59:00 as label points
                       "2007-02-02 23:59:00")),labels = c("Thu", "Fri", "Sat")) #New label as "Thu, Fri and Sat"

dev.off() #Closes the file
