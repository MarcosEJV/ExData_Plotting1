library(dplyr) #Package to edit table

table <- read.csv("./household_power_consumption.txt", sep = ";") #Read the file
table <- tbl_df(table)

targetdate1 <- table %>% filter(Date == "1/2/2007") #Read first day
targetdate2 <- table %>% filter(Date == "2/2/2007") #Read second day
targetdates <- targetdate1 %>% rbind(targetdate2)   #Bind both days

png("plot1.png", width = 480, height = 480, units = "px") #Open png file
hist(as.numeric(targetdates$Global_active_power), col = "red", #Build the figure
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off() #Close the figure and save it
