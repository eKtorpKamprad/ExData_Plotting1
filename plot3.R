# Code variables
fileUrl         <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataPath        <- "data/data_science_specialization/04_Exploratory_Data_Analysis_PA01"
fileToDownload  <- "household_power_consumption.zip"
datasetName     <- "household_power_consumption.txt"

# Downloading and unziping dataset
if (!file.exists(dataPath)){
        dir.create(dataPath, showWarnings = FALSE, recursive = TRUE)
}
fileDownloaded  <- file.path(dataPath,fileToDownload)
download.file(fileUrl,fileDownloaded)
unzip(zipfile=fileDownloaded,exdir=datasetPath)

# Reading dataset and loading in memory only rows from the dates 2007-02-01 and 2007-02-02.
datasetPath     <- file.path(dataPath,datasetName)
dat             <- read.table(text = grep("^[1,2]/2/2007", readLines(datasetPath), value = TRUE), 
                              col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                                            "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                                            "Sub_metering_3"),
                              header = TRUE, sep=";", dec=".", na.string="?")

# Combining Date and Time fields to obtain the expected format
dat$Date        <- as.Date(dat$Date, format = "%d/%m/%Y")
dateAndTime     <- as.POSIXct(paste(as.Date(dat$Date), dat$Time))

# Opening a png grafic device 
png("plot3.png", width=480, height=480)
# Plotting
with(dat,{
     plot(Sub_metering_1 ~ dateAndTime, type = "l", ylab = "Energy sub metering", xlab = "")
     lines(Sub_metering_2 ~ dateAndTime, type = "l", col = "red")
     lines(Sub_metering_3 ~ dateAndTime, type = "l", col = "blue")     
     })
legend("topright", col = c("black","red","blue"), lty = 1, lwd = 2,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()