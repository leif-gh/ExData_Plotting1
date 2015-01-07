## Plot 1 script
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
## Plot - Histogram of active power component
  plot_var <- as.numeric(data_sub$Global_active_power)
  par(mfrow = c(1, 1), mar = c(4, 5, 5, 1), oma = c(0, 0, 2, 0))
  hist(plot_var, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
  mtext("Plot 1", line = 4, outer = FALSE, adj = 0, at = -2, font = 2)
## Export to png in wd
  dev.copy(png, file = "plot1.png", width = 480, height = 480)
  dev.off()
## End of Plot 1 task
