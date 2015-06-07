plot1 <- function() {
  
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
  
  #### Histogram  : plot1
  hist(data$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  cat("Plot1.png has been saved in", getwd())
}
plot1()