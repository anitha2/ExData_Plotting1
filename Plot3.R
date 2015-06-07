plot3 <- function() {
  if (!file.exists("housepow.zip")) {
    download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile="housepow.zip")
    unzip("housepow.zip")  
  }
  
  
  ## Getting full dataset
  data_full <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?" ,quote='\"')
  data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")
  
  ## Subsetting the data
  data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
  rm(data_full)
  
  ## Converting dates
  datetime <- paste(as.Date(data$Date), data$Time)
  data$Datetime <- as.POSIXct(datetime)
  
  ### Plot the figue 3 in the file 
  png(filename="plot3.png", width=480, height=480)
  plot(data$Datetime,data$Sub_metering_1, type="l",
       col="black", xlab="", 
       ylab="Energy sub metering", 
       main="")
  lines(data$Datetime, data$Sub_metering_2, col="red")
  lines(data$Datetime, data$Sub_metering_3, col="blue")
  legend("topright", lwd=1, lty=1, 
         col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
   
  dev.off()
  cat("plot3.png has been saved in", getwd())
}
plot3()