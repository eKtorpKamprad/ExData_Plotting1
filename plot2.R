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

# Combining Date and Time fields
dat$Date        <- as.Date(dat$Date, format = "%d/%m/%Y")

# Opening a png grafic device
png("plot2.png", width=480, height=480)
# Plotting a line chart
plot(dat$Global_active_power ~ as.POSIXct(paste(as.Date(dat$Date), dat$Time)), 
     type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()