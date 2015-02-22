##GCD COURSE PROJECT##

setwd("C:/Users/Carlos Díaz/Dropbox/Coursera/Datascesp/GCD")

#Downloading files#
if (!file.exists("data")) {
  dir.create("data")
}

fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, dest = "./data/projGCD.zip")
unzip("./data/projGCD.zip", exdir = "./data/unzip")