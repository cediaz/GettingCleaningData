##GCD COURSE PROJECT##

setwd("C:/Users/Carlos Díaz/Dropbox/Coursera/Datascesp/GCD")



#Downloading files#
if (!file.exists("data")) {
  dir.create("data")
}

fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, dest = "./data/projGCD.zip")
unzip("./data/projGCD.zip", exdir = "./data/unzip")

#################################################
setwd("C:/Users/Carlos Díaz/Dropbox/Coursera/Datascesp/GCD/data/unzip/UCI HAR Dataset")

#Reading and creating one data training-test set:
################################################


library("dplyr")
library("reshape2")

X_trn <- read.table("./train/X_train.txt")
Y_trn <- read.table("./train/Y_train.txt")
Sub_trn <- read.table("./train/subject_train.txt")

#datos training
Xtrn = X_trn
Xtrn[,562] = Y_trn
Xtrn[,563]= Sub_trn

#For test data:

X_tst <- read.table("./test/X_test.txt")
Y_tst <- read.table("./test/Y_test.txt")
Sub_tst <- read.table("./test/subject_test.txt")

#datos test
Xtst = X_tst
Xtst[,562] = Y_tst
Xtst[,563]= Sub_tst

#Getting the names
actvt_lbl=read.table("./activity_labels.txt")
feat=read.table("./features.txt")
feat[,2]=gsub('-mean', 'Mean', feat[,2])
feat[,2] = gsub('-std', 'Std', feat[,2])
feat[,2] = gsub('[-()]', '', feat[,2])

##1->Merge training and test data:

TTall=rbind(Xtrn, Xtst)

##2->Extracts only the measurements on the mean and standard deviation for each measurement.
Data_filt=grep(".*Mean.*|.*Std.*", feat[,2])
feat = feat[Data_filt,]
Data_filt = c(Data_filt, 562, 563)

#Database filtered:

TTall = TTall[,Data_filt]

#4 Appropriately labels the data set with descriptive variable names. :

colnames(TTall)=c(feat$V2, "Activity", "Subject")
View(TTall)

#3->Uses descriptive activity names to name the activities in the data set
currentActivity = 1
for (currentActivityLabel in actvt_lbl$V2) {
  TTall$Activity <- gsub(currentActivity, currentActivityLabel, TTall$Activity)
  currentActivity <- currentActivity + 1
}

#5->From the data set in step 4, creates a second, independent tidy data set with the average 
#of each variable for each activity and each subject.

TTall$Activity <- as.factor(TTall$Activity)
TTall$Subject <- as.factor(TTall$Subject)

tidyAvrg_data = aggregate(TTall, by=list(Activity = TTall$Activity, subject=TTall$Subject), mean)
tidyAvrg_data[,90] = NULL
tidyAvrg_data[,89] = NULL
write.table(tidyAvrg_data, "tidy_avrg.txt", sep="\t")
View(tidyAvrg_data)
