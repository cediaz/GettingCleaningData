##WEEK 3##

setwd("C:/Users/Carlos Díaz/Dropbox/Coursera/Datascesp/GCD")


#Lecture 1: sUBSETTING AND SORTING

set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5), ]; X$var2[c(1,3)]=NA
X[1:4, 2]
#subgrupos valores lógicos (y/o)
X[(X$var1<=3 & X$var3>11),]
X[(X$var1<=3 | X$var3>11),]
X[X$var2 > 8,]
X[which(X$var2 > 8),]
sort(X$var1)
sort(X$var1, decreasing = T)
sort(X$var2, na.last = T)
X[order(X$var1),]
#install.packages("plyr")
#library("plyr")
#arrange(X,var1)

#añadir columnas
X$var4<-rnorm(5)

#Lecture2 W3: Summarizing data

fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
if(!file.exists("./data")){dir.create("./data")}
download.file(fileUrl, dest = "./data/restaurants.csv")
restData = read.csv("./data/restaurants.csv")

head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)

quantile(restData$councilDistrict, na.rm=T)
quantile(restData$councilDistrict, na.rm=T, probs=c(0.5, 0.75, 0.9))

table(restData$zipCode, useNA="ifany")
table(restData$councilDistrict, restData$zipCode)

sum(is.na(restData$zipCode))
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
any(is.na(restData$zipCode > 0))

#suma de columnas
colSums(is.na(restData))
all(colSums(is.na(restData))==0)

table(restData$zipCode %in% ("21212"))
table(restData$zipCode %in% c("21212", "21213"))
 #subgrupos usando %in%
restData[restData$zipCode %in% c("21212", "21213"), ]
subZip <- restData[restData$zipCode %in% c("21212", "21213"), ]

#Cross Tabs

data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt = xtabs(Freq ~ Gender + Admit, data = DF)
xt

#Flat tables
data(warpbreaks)
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data=warpbreaks)
xt
ftable(xt)

#size of data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")



##QUIZ 3##

#Q1
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, dest="./data/idahousing.csv")
dataQ1 = read.csv("./data/idahousing.csv")
X1<-dataQ1[which(dataQ1$ACR == 3 & dataQ1$AGS==6), ]
head(X1, n=3)
head(dataQ1[which(dataQ1$ACR == 3 & dataQ1$AGS==6), ], n=3)


#Q2
install.packages("jpeg")
library("jpeg")
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, dest = "./data/GCD.jpeg", mode='wb')
Pic = readJPEG("./data/GCD.jpeg", native=T)
quantile(Pic, probs = c(0.3, 0.8))

#Q3

fileGDP ="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileEdu = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileGDP, dest = "./data/GDP.csv")
download.file(fileEdu, dest = "./data/Edu.csv")
GDP <- read.csv("./data/GDP.csv", header=F, skip=5, nrows=190)
Edu <- read.csv("./data/Edu.csv")
GDP1 = data.frame(GDP)
EDU1 = data.frame(Edu)
head(GDP1, n=4); head(EDU1, n=4)
names(GDP1)
names(EDU1)
MergeData = merge(GDP1, EDU1, by.x ="V1", by.y ="CountryCode", sort=T)
head(MergeData)
names(MergeData)
Q3F<-MergeData[order(MergeData$V2, decreasing=T), ]

dim(Q3F)
Q3F[13,4]

#Q4
Q4A=MergeData[(MergeData$Income.Group=="High income: OECD"), ]
summary(Q4A)
mean(Q4A$V2)

Q4B=MergeData[(MergeData$Income.Group=="High income: nonOECD"), ]
summary(Q4B)
mean(Q4B$V2)

#Q5
quantile(MergeData$V2, probs=c(0.2, 0.4, 0.6, 0.8))
X<-table(MergeData$V2, MergeData$Income.Group)
X2<-data.frame(X[1:38,])
head(X2, n=3)
sum(X2$Lower.middle.income)
