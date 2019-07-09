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
plot(df$Global_active_power~df$dateTime, type="l", ylab="Global Active Power (kilowatts)",xlab=" ")

# save plot to PNG file
dev.copy(png,"plot2.png")
dev.off()

