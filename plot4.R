## To start running the script first download the "exdata-data-household_power_consumption.zip" file and unzip in your working directory
## The script will use the TXT file named: "household_power_consumption.txt".
## If you don´t have the file you can use the follow code:
##
## fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
## download.file(fileUrl, destfile = "./CourseProjectData.zip", method = "curl")
## dateDownloaded <- date()
##
## unzip("./CourseProjectData.zip", overwrite = TRUE, exdir = "./")
##

## 1. Load the data into a "J" variable
j <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses = "character")

## Check number of rows
nrow(j) 	## 2,075,259

## 2. Separate data for dates "01/02/2007" and "02/02/2007"
a <- j[(j$Date=="1/2/2007"),]

b <- j[(j$Date=="2/2/2007"),]

## 3. Creates the dataset for analysis
c <- rbind(a,b)

## 4. Add a column with the DateTime value for each observation
c$DateTime <- strptime(paste(as.character(as.Date(gsub("2/","02",gsub("1/","01",c$Date)),format="%d%m%Y")),c$Time),"%Y-%m-%d %H:%M:%S")

## 5. Generates Plot 2
par(mfrow=c(2,2))

## 1,1
plot(as.numeric(c$Global_active_power), c$Datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## 1,2
plot(as.numeric(c$Voltage), c$Datetime, type="l", xlab="datetime", ylab="Voltage")

## 2,1
plot(as.numeric(c$Sub_metering_1), c$Datetime, type="n", xlab="", ylab="Energy sub metering")
lines(as.numeric(c$Sub_metering_1), c$Datetime, col="black")
lines(as.numeric(c$Sub_metering_2), c$Datetime, col="red")
lines(as.numeric(c$Sub_metering_3), c$Datetime, col="blue")
legend( 900, 40, box.col = "white", pch ="-", col = c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
##legend( 1, 1, box.col = "white", pch ="-", col = c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))  

## 2,2
plot(as.numeric(c$Global_reactive_power), c$Datetime, type="l", xlab="datetime", ylab="Global_reactive_power")

## 6. Copy into a PNG file
dev.copy(png, file="plot4.png")
dev.off()
