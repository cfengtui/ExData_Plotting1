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
with(df, {
     plot(Sub_metering_1~dateTime, type="l",
          ylab="Energy Sub metering", xlab="")
     lines(Sub_metering_2~dateTime,col='Red')
     lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1.5,1.5,1.5), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# save plot to PNG file
dev.copy(png,"plot3.png",height=480, width=720)
dev.off()

