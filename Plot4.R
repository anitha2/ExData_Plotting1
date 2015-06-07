plot4 <- function() { 
   ## read url 
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
   ##### First create png file and then try to plot on it
  png("plot4.png", width=580, height=580)
  
  par(mfrow=c(2,2))
  # 1 plot DT vs Gloab active pow
  plot(data$Datetime, data$Global_active_power,
       type="l",
       xlab="",
       ylab="Global Active Power")
  # 2 plot DT vs Voltage
  plot(data$Datetime, data$Voltage, type="l",
       xlab="datetime", ylab="Voltage")
  # 3plot DT vs submet
  #par(xpd=T)
  plot(data$Datetime, data$Sub_metering_1, type="l", col="black",
       xlab="", ylab="Energy sub metering")
  lines(data$Datetime, data$Sub_metering_2, col="red")
  lines(data$Datetime, data$Sub_metering_3, col="blue")
  #bty removes the box, cex shrinks the text
  legend("topright",
         col=c("black", "red", "blue"),lty=1,lwd=1, bty="n",         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  # 4 DT vs reactive power
  plot(data$Datetime, data$Global_reactive_power, type="n",
       xlab="datetime", ylab="Global_reactive_power")
  lines(data$Datetime, data$Global_reactive_power) 
  dev.off()
  cat("plot4.png has been saved in", getwd())
  
}
plot4()