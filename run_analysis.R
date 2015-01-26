## load library dplyr
library(plyr); library(dplyr)
##Read files features and activity_lables text files into dataframes
activelabel <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

##Read files y_test,y_train,Subject_test,Subject_train into dataframes
##and  Replace activity numbers with Activity names
subjecttrain <-read.table("UCI HAR Dataset/train/subject_train.txt")
datatrainy <-read.table("UCI HAR Dataset/train/y_train.txt") %>%
        join(y=activelabel,by="V1") %>%
        ##bind Dataframes y_train and subject_train 
        cbind("Subject"=subjecttrain$V1)

subjecttest <-read.table("UCI HAR Dataset/test/subject_test.txt")
datatesty <-read.table("UCI HAR Dataset/test/y_test.txt") %>%
        join(y=activelabel,by="V1") %>%
        ##bind Dataframes y_test and subject_test 
        cbind("Subject"=subjecttest$V1)
##Merge datatrainy and datatesty (dim-10299*2) -> totaly
##and Extracts only Activity & Subject variable 
totaly <-rbind(datatrainy,datatesty) %>%
        select("Activity"=V2,Subject)
##Read files X_test,X_train into dataframes
datatrain <-read.table("UCI HAR Dataset/train/X_train.txt") 
datatest <-read.table("UCI HAR Dataset/test/X_test.txt")
##Merge X_train and X_test data -> totaldata (10299*561)
totaldata <- rbind(datatrain,datatest)
##Change variable names of totaldata from features
names(totaldata) <-c(as.character(features$V2))
##Extracts columns from totaldata which have "mean()" or "std()"
##in the column names.
extrdata<- totaldata[,grep("mean\\(\\)|std\\(\\)",names(totaldata))]
##bind extrdata and totaly (10299*68)
tidydata1 <- cbind(extrdata,totaly)
## From the data set in step 4
attach(extrdata)
## Take mean of observations per activity per subject. (180*68). 
tidydata2 <- aggregate(extrdata, by=list(Activity=Activity,Subject=Subject), FUN=mean)
## write to TidyData.txt txt file
write.table(x=tidydata2,"TidyData.txt",row.names=FALSE)