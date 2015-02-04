# plot3.R
# Edwin Seah 20150205013800
#
# Script to reconstruct sample plot 3 using base plotting system
# Forked instructions: "https://github.com/rdpeng/ExData_Plotting1"
# Dataset link: "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# Data dimensions: 2,075,259 rows and 9 columns, 133MB
# Date Range: 2007-02-01 and 2007-02-02
# Missing values: "?"
# Delimiter: ";"
# Outputs: "plot3.png"

# Sample Data
# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;
# Sub_metering_1;Sub_metering_2;Sub_metering_3
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

plot3 <- function() {
    rawfile <- "household_power_consumption.txt"
    row_start <- 66636  # starting entry row for 1/2/2007
    row_end <- 69516    # last entry row for 2/2/2007
    df <- read.csv2(rawfile, header=TRUE, sep=";", na.strings="?",
                    colClasses="character",
                    col.names=c("D", "T", "GA", "GR", "V", 
                                "GI", "SM1", "SM2", "SM3"),
                    nrows=(row_end - row_start), 
                    skip=row_start)
    
    sm.df <- subset(df, select=c(D, T, SM1, SM2, SM3))
    sm.df$DT <- strptime(paste(sm.df$D, sm.df$T), format="%d/%m/%Y %T")
    png(filename="plot3.png", width=480, height=480, units="px")
    plot(sm.df$DT, 
         sm.df$SM1, 
         type="l", 
         xlab="", 
         ylab="Energy sub metering")
    lines(sm.df$DT, sm.df$SM2, col="red")
    lines(sm.df$DT, sm.df$SM3, col="blue")
    legend("topright", 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col=c("black", "red", "blue"),
           lty=1)
    dev.off()
}
