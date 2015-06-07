plot2 <- function() {
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
  ## PLot the graph 2
  plot(data$Datetime,data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot2.png", width=480, height=480)
  dev.off()
  cat("plot2.png has been saved in", getwd())
}
plot2()