## Plot 4 script
## Download the data
  fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  ## create a temporary directory
  td = tempdir()
  ## create a temporary placeholder file
  tf = tempfile(tmpdir=td, fileext=".zip")
  ## download file into placeholder
  download.file(fileUrl, tf)
  ## get the name of the first file in the zip archive
  fname = unzip(tf, list=TRUE)$Name[1]
  ## fname "household_power_consumption.txt"
  ## unzip the file to the temporary directory
  unzip(tf, files=fname, exdir=td, overwrite=TRUE)
  ## fpath is the full path to the extracted file
  fpath = file.path(td, fname)
  ## fpath on Windows "C:\\Users\\Admin\\AppData\\Local\\Temp\\RtmpK4JOeA/household_power_consumption.txt"
## Read data into R
  data <- read.table(fpath, header=TRUE, row.names=NULL, stringsAsFactors=FALSE, sep = ";")
## Transform
  ## head(data)
  data$Date <- as.Date(data$Date, "%d/%m/%Y")   ## capital Y; class Date
  ## subset to Feb 1 and 2 2007
  data_logical <- data[,1] == "2007-02-01" | data[,1] == "2007-02-02"
  data_sub <- data[data_logical, ]
  ## head(data_sub)
## Create data frame to plot  
  ## create date_time object out of Date and Time
  date_time <- paste(data_sub[, 1], data_sub[, 2])  ## paste Date and Time
  date_time <- strftime(date_time, "%s")  ## time in seconds since ref time
  date_time <- as.numeric(date_time[]) - as.numeric(date_time[1])  ## time in seconds since start of time in dataset
  date_time <- date_time/60  ## time in minutes to be used as x coordinate in plot
  ## create plot data frames
  d_plot1 <- data.frame(cbind(date_time, as.numeric(data_sub$Global_active_power)))
  d_plot2 <- data.frame(cbind(date_time, as.numeric(data_sub$Sub_metering_1), as.numeric(data_sub$Sub_metering_2), as.numeric(data_sub$Sub_metering_3)))
  d_plot3 <- data.frame(cbind(date_time, as.numeric(data_sub$Voltage)))
  d_plot4 <- data.frame(cbind(date_time, as.numeric(data_sub$Global_reactive_power)))
## Plot - Four component diagram
  par(mfcol = c(2, 2), mar = c(4, 5, 3, 1), oma = c(0, 0, 2, 0))
  ## diagram 1
  plot(date_time, d_plot1[,2], type = "l", ylab = "Global Active Power", xlab = "", xaxt = "n", cex.lab=0.8, cex.axis=0.8)
  axis(1, at = c(0, 1440, 2880), labels = expression(Thu, Fri, Sat), cex.axis=0.8)
  mtext("Plot 4", line = 3, adj = 1.5, at = 1, font = 2)
  ## diagram 2
  plot(date_time, d_plot2[,2], type = "n", ylab = "Energy sub metering", xlab = "", xaxt = "n", cex.lab=0.8, cex.axis=0.8)
  axis(1, at = c(0, 1440, 2880), labels = expression(Thu, Fri, Sat), cex.axis=0.8)
  lines(date_time, d_plot2[,2], type = "l", col = "black")
  lines(date_time, d_plot2[,3], type = "l", col = "red")
  lines(date_time, d_plot2[,4], type = "l", col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"), bty="n", cex=0.75)
  ## diagram 3
  plot(date_time, d_plot3[,2], type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n", cex.lab=0.8, cex.axis=0.8)
  axis(1, at = c(0, 1440, 2880), labels = expression(Thu, Fri, Sat), cex.axis=0.8)
  ## diagram 4
  plot(date_time, d_plot4[,2], type = "l", ylab = "Global_reactive_power", xlab = "datetime", xaxt = "n", cex.lab=0.8, cex.axis=0.8)
  axis(1, at = c(0, 1440, 2880), labels = expression(Thu, Fri, Sat), cex.axis=0.8) 
## Export to png in wd
  dev.copy(png, file = "plot4.png", width = 480, height = 480)
  dev.off()
## End of Plot 4 task
