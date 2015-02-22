#Getting and Cleaning Data semanas 1 y 2
setwd("/home/carlos/Dropbox/Coursera/Datascesp/GCD")
getwd()

#Downloading files#
if (!file.exists("data")) {
  dir.create("data")
}

  fileUrl <- "http://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv")

list.files("./data")
dateDownloaded = date()
dateDownloaded

#Reading Data#
Camaras <- read.csv("./data/cameras.csv")

#Reading excel data#
fileUrlXlsx = "http://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrlXlsx, destfile="./data/cameras.xlsx")
# No se puede en Ubuntu; install.packages("xlsx")
# No se puede en Ubuntu; library("xlsx")
#El siguiente paquete no presenta problema alguno:
install.packages("gdata")
require(gdata)
cameraData = read.xls("./data/cameras.xlsx", sheet = 1, header = T)

#Reading XML data

library("XML")
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]]
rootNode[[1]][[1]]
rootNode[[2]][[1]]

xmlSApply(rootNode, xmlValue)
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

#Reading JSON *JavaScript Object Notation

library("jsonlite")
jsonData = fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

#Paquete data.table
library(data.table)
DF = data.frame(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DF, 3)

DT = data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DT, 3)
DT[2,]
DT[DT$y=="a",]
DT[,w:=z^2]
DT


#qUIZ 2
#Q1
library(httr)
myapp = oauth_app("economicana", key="8d650b98f010f065bf00", secret ="b8340d5be9ac42704a0f198f578ba75c29e424aa")
sign = sign_oauth1.0(myapp, token = "cediaz", token_secret="C672790667edv$")
homeTL = GET("https://api.github.com/users/jtleek/repos", sign)

#Q2
install.packages("sqldf")
library("sqldf")
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./data/question2.csv")
acs = read.csv("./data/question2.csv")
library("sqldf")
a = sqldf("select * from acs where AGEP < 50 and pwgtp1")
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select * from acs where AGEP < 50")

x=unique(acs$AGEP)
x
sqldf("select AGEP where unique from acs")
x
sqldf("select distinct AGEP from acs")
x
sqldf("select distinct pwgtp1 from acs")
x
sqldf("select unique AGEP from acs")


#Q4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
sapply(htmlCode[c(10, 20, 30, 100)], nchar)

#Q5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", destfile="./data/datafor.for") 

list.files()
data <- read.csv("./data/datafor.for", header=T)
head(data)
dim(data)
file_name <- "./data/datafor.for"
df <- read.fwf(file=file_name,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
head(df)
sum(df[, 4])

