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
plot(as.numeric(c$Global_active_power), c$Datetime, type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")
axis(1, at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))

## 6. Copy into a PNG file
dev.copy(png, file="plot2.png")
dev.off()
