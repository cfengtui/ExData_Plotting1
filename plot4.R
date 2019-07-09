download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","df.zip")
unzip ("df.zip")
mydata<-read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

df<-mydata

# Filter data set from Feb. 1, 2007 to Feb. 2, 2007
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df <- subset(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Remove incomplete observation
df <- df[complete.cases(df),]

# combine date and time
df$dateTime <- as.POSIXct(paste(df$Date, df$Time))

# generate plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
#1
plot(df$Global_active_power~df$dateTime, type="l", ylab="Global Active Power (kilowatts)",xlab=" ")
#2
plot(df$Voltage~df$dateTime, type="l", ylab="Voltage (Volt)",xlab="datetime")
#3
with(df, {
     plot(Sub_metering_1~dateTime, type="l",
          ylab="Energy Sub metering", xlab="")
     lines(Sub_metering_2~dateTime,col='Red')
     lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"),  lwd=2.5, bty="n", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#4
plot(df$Global_reactive_power~df$dateTime, type="l", ylab="Global Reactive Power (kilowatts)",xlab="datetime")

# save plot to PNG file
dev.copy(png,"plot4.png",height=480, width=720)
dev.off()

