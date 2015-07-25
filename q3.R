library(dplyr)
library(jpeg)

#q1
if (!file.exists("getdata%2Fdata%2Fss06hid.csv")) {
  fURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
  download.file(fURL,destfile="getdata%2Fdata%2Fss06hid.csv")
}

data <- read.csv("getdata%2Fdata%2Fss06hid.csv")

agricultureLogical <- (data$AGS == 6 & data$ACR == 3)

print("Q1")
print(head(which(agricultureLogical)))

#2

if (!file.exists("getdata%2Fjeff.jpg")) {
  fURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
  download.file(fURL,destfile="getdata%2Fjeff.jpg")
}

data <- readJPEG("getdata%2Fjeff.jpg", native=TRUE)

#not sure this is working...
##needs to be download elsewhere, answer is       30%       80% 
#-15259150 -10575416 
print("Q2")
print(quantile(data, probs = c(0.3, 0.8)))


if (!file.exists("getdata%2Fdata%2FGDP.csv")) {
  fURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(fURL,destfile="getdata%2Fdata%2FGDP.csv")
}

gdpData <- read.csv("getdata%2Fdata%2FGDP.csv")
newGDP <- gdpData[c(seq(5,194)),c(1,2,5)]
names(newGDP) <- c("CountryCode", "Rank", "millions")

if (!file.exists("getdata%2Fdata%2FEDSTATS_Country.csv")) {
  fURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(fURL,destfile="getdata%2Fdata%2FEDSTATS_Country.csv")
}

edData <- read.csv("getdata%2Fdata%2FEDSTATS_Country.csv")

final <- merge(edData, newGDP, by="CountryCode")
final <- mutate(final, Rank = as.numeric(as.character(final$Rank)))
final <- final[order(final$Rank,decreasing = TRUE),]

print("Q3")
print(length(final$CountryCode))
print(final[13,"Table.Name"])

print("Q4")
print(mean(final[(final$Income.Group == "High income: OECD"), "Rank"]))
print(mean(final[(final$Income.Group == "High income: nonOECD"), "Rank"]))

print("Q5")
q5 <- head(final[order(final$Rank),"Income.Group"], 38)
print(sum(q5 == "Lower middle income"))
