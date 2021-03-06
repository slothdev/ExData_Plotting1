# plot4.R
# Edwin Seah 20150205025357 SGT
#
# Script to reconstruct sample plot 4 using base plotting system
# Forked instructions: "https://github.com/rdpeng/ExData_Plotting1"
# Dataset link: "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# Data dimensions: 2,075,259 rows and 9 columns, 133MB
# Date Range: 2007-02-01 and 2007-02-02
# Missing values: "?"
# Delimiter: ";"
# Outputs: "plot4.png"

# Sample Data
# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;
# Sub_metering_1;Sub_metering_2;Sub_metering_3
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

plot4 <- function() {
    rawfile <- "household_power_consumption.txt"
    row_start <- 66636  # starting entry row for 1/2/2007
    row_end <- 69516    # last entry row for 2/2/2007
    df <- read.csv2(rawfile, header=TRUE, sep=";", na.strings="?",
                    colClasses="character",
                    col.names=c("D", "T", "GA", "GR", "V", 
                                "GI", "SM1", "SM2", "SM3"),
                    nrows=(row_end - row_start), 
                    skip=row_start)

    df$DT <- strptime(paste(sm.df$D, sm.df$T), format="%d/%m/%Y %T")

    # open graphics device and set 2x2 plot layout with mfrow
    png(filename="plot4.png", width=480, height=480, units="px")
    par(mfrow=c(2,2))
    
    # topleft plot - Global Active Power by DateTime
    plot(df$DT, df$GA, type="l", 
         xlab="", ylab="Global Active Power (kilowatts)")
    
    # topright plot - Voltage by DateTime
    plot(df$DT, df$V, type="l", 
         xlab="datetime", ylab="Voltage")
    
    # bottomleft plot - Sub metering by DateTime
    plot(df$DT, df$SM1, type="l", 
         xlab="", ylab="Energy sub metering")
    lines(df$DT, df$SM2, col="red")
    lines(df$DT, df$SM3, col="blue")
    legend("topright", 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col=c("black", "red", "blue"),
           lty=1, bty="n")
    
    # bottomright plot - Global Reactive Power by DateTime
    plot(df$DT, df$GR, type="l", 
         xlab="datetime", ylab="Global_reactive_power")
  
    # close graphics device
    dev.off()
}
