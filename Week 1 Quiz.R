fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = fileurl, destfile = "/Users/vtika/Desktop/American_Comm_Inst.csv", mode = "w", method = "curl")
list.files(".")
datedownloaded <- date()
datedownloaded

American_Comm_Inst <- read.csv("/Users/vtika/Desktop/American_Comm_Inst.csv")

length(American_Comm_Inst$VAL[!is.na(American_Comm_Inst$VAL) & American_Comm_Inst$VAL==24])

fileurl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url = fileurl1, destfile="/Users/vtika/Desktop/gov_NGAP.xlsx", mode="w", method="curl")
print(datedownloaded)
