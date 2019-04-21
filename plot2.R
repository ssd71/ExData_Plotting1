library(dplyr)
library(readr)


if(!file.exists("exdata_data_household_power_consumption.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "exdata_data_household_power_consumption.zip"
    )
}



electricalpower <- read_delim("exdata_data_household_power_consumption.zip",
                              delim = ';', 
                              na = '?', 
                              col_types = cols(
                                  Date = col_date(format="%d/%m/%Y"),
                                  Time = col_time(format = "%H:%M:%S"),
                                  Global_active_power = col_double(),
                                  Global_reactive_power = col_double(),
                                  Voltage = col_double(),
                                  Global_intensity = col_double(),
                                  Sub_metering_1 = col_double(),
                                  Sub_metering_2 = col_double(),
                                  Sub_metering_3 = col_double()
                              ),
                              skip = 66637,
                              n_max = 2880,
                              col_names = c("Date","Time", "Global_active_power",
                                            "Global_reactive_power",
                                            "Voltage",
                                            "Global_intensity",
                                            "Sub_metering_1",
                                            "Sub_metering_2",
                                            "Sub_metering_3")
)


electricalpower <- mutate(electricalpower, 
                          dtime=as.POSIXct(strptime(
                              paste(electricalpower$Date, electricalpower$Time), 
                              format="%Y-%m-%d %H:%M:%S"
                          ))
)

png('plot2.png', height = 480, width = 480)

with(electricalpower, plot(dtime,Global_active_power, 
                           type = 'l', 
                           xlab='', 
                           ylab = 'Global Active Power (kilowatts)'
                      )
)

dev.off()
