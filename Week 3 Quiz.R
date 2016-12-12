##For Question 1##
fileurl <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "/Users/vtika/Desktop/R Programming/Getting And Cleaning Data/Week 3/2006 Mirodata Survey.csv")

file <- read.csv("/Users/vtika/Desktop/R Programming/Getting And Cleaning Data/Week 3/2006 Mirodata Survey.csv")

agriculturelogical <- file$ACR == 3 & file$AGS == 6 
which(agriculturelogical)[1:3]

##Question 2##
jpegurl <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "/Users/vtika/Desktop/R Programming/Getting And Cleaning Data/Week 3/guy.jpg", mode = "wb")
jpegfile <- readJPEG("/Users/vtika/Desktop/R Programming/Getting And Cleaning Data/Week 3/guy.jpg", native = TRUE)
quantile(jpegfile, probs = c(.3, .8))

##Question 3##
GDPurl <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "/Users/vtika/Desktop/R Programming/Getting And Cleaning Data/Week 3/GDP.csv")
GDPcsv <- "/Users/vtika/Desktop/R Programming/Getting And Cleaning Data/Week 3/GDP.csv"
dtGDP <- data.table(read.csv(GDPcsv, skip = 4, nrows = 215))
dtGDP <- dtGDP[X !=""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))

FedStatsurl <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
                            "/Users/vtika/Desktop/R Programming/Getting And Cleaning Data/Week 3/FedStats.csv")
FedStatscsv <-"/Users/vtika/Desktop/R Programming/Getting And Cleaning Data/Week 3/FedStats.csv"
dtFedStats <- data.table(read.csv(FedStatscsv))
dt <- merge(dtGDP, dtFedStats, all = TRUE, by = c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))

dt[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y, 
                                              rankingGDP, gdp)][13]

##Question 4##
dt[, mean(rankingGDP, na.rm = TRUE), by = Income.Group]

##Question 5##
breaks <- quantile(dt$rankingGDP, probs = seq(0,1,0.2), na.rm = TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks = breaks)
dt[Income.Group == "Lower middle income", .N, by = C("Income.Group", "quantileGDP")]
