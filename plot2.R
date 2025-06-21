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
     ylab = "Global Active Power (kilowatts)")

dev.off() #Closes the file
