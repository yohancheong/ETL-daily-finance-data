
## Get daily financial data for designated ticker
## (by Christopher Yohan, Chung on 22 Oct 2015)

# Input ticker
ticker <- "CAR.AX"

# Input startdate
startDate <- "2015-01-01"
sd <- as.Date(startDate, format="%Y-%m-%d") 

# Input enddate
endDate <- "2015-10-21"
ed <- as.Date(endDate, format="%Y-%m-%d") 

# Format url
url <- paste("http://real-chart.finance.yahoo.com/table.csv?s=",
             ticker,"&a=",
             (as.numeric(format(sd, format = "%m"))-1),"&b=",
             as.numeric(format(sd, format = "%d")),"&c=",
             as.numeric(format(sd, format = "%Y")),"&d=",
             as.numeric(format(ed, format = "%m")),"&e=",
             as.numeric(format(ed, format = "%d")),"&f=",
             as.numeric(format(ed, format = "%Y")),"&g=d&ignore=.csv", sep="")

# Request data & retrieve output as dataframe
yahoo.read <- function(url){
  df <- read.table(url, header=TRUE, sep=",")
  return(df)
}

car  <- yahoo.read(url)

# Save dataframe as csv
filename <- paste(ticker,"_", gsub("-", "_", startDate),"_", gsub("-", "_", endDate), ".csv", sep="")
write.table(car, file = filename, row.names=F,col.names=F,sep=",")

