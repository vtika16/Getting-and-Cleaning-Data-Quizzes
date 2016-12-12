##Question 1##
fileurl <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "getdata.csv")
file <- read.csv("getdata.csv")
filename <- names(file)

filespl <- strsplit(filename, split = "wgtp")
filespl[[123]]

##Question 2##
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "GDP.csv")
download.file(url, f)
dataGDP <- data.table(read.csv(f, skip = 4, nrows = 215, stringsAsFactors = FALSE))
dataGDP <- dataGDP[X != ""]
dataGDP <- dataGDP[, list(X, X.1, X.3, X.4)]
setnames(dataGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", dataGDP$gdp))

mean(gdp, na.rm = TRUE)

##Question 3##
isUnited <- grepl("^United", dtGDP$Long.Name)
summary(isUnited)

##Question 4##
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDStats_Country.csv")
download.file(fileurl, f)
dataEd <- data.table(read.csv(f))
data <- merge(dataGDP, dataEd, all = TRUE, by = c("CountryCode"))
isFiscalYearEnd <- grepl("fiscal year end", tolower(data$Special.Notes))
isJune <- grepl("june", tolower(data$Special.Notes))
table(isFiscalYearEnd, isJune)
data[isFiscalYearEnd & isJune, Special.Notes]

##Question 5##
amzn <- getSymbols("AMZN", auto.assign = FALSE)
sampleTimes <- index(amzn)
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
