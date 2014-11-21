#####################################################################
##  run_analysis.R      for 'Getting & Cleaning Data' DSCoursera
##
##  S. Mass / Nov 16, 2014
##
#####################################################################
##
## Create one R script called run_analysis.R that does the following:
##  1. Merge training and test sets 
##  2. Extract mean and sd for each measurement
##  3. Rename activities with descriptive names
##  4. Label data set with descriptive variable names
##  5. Create a new Tidy data set with averages of each 
##      variable for each activity and each subject
##
######################################################################
##
## Assumptions: working directory contians subdirectory 'UCI HAR Dataset'
## which contains subdirectories 'test' and 'train' with data txt files.
##
## Requires plyr and dplyr
##
########
## check to see if plyr is installed and loaded. If available load, 
## if not install it
if (!"plyr" %in% installed.packages()){
    install.packages("plyr")
}else{suppressMessages(library(plyr))}
## check to see if dplyr is installed and loaded. If available load, 
## if not install it
if (!"dplyr" %in% installed.packages()){
    install.packages("dplyr")
}else{suppressMessages(library(dplyr))}

########
## load feature file
features <- read.table("UCI HAR Dataset/features.txt", quote="\"")
## load activity file
activity <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"")


######## Read in the test and train data files
### TEST data
## load test files
testDF <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")
### TRAIN data
## load train files
trainDF <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")
########
### fix names
## extract column names from features
badNames <- features$V2
## rename things with valid names & eliminate duplicates
legalNames <-make.names(badNames, unique=TRUE, allow_ = TRUE)
## Cleanup the legal names by changing initial 'f' to 'FFT' and 't' to 
## 'Total' and eliminating all of the periods and elipses, and 
## the 'bodybody" double typo. Change 'mean' to 'Mean' and 'std to 'STD'
bigtNames <- gsub("^[t]","Total", legalNames)
bigfNames <- gsub("^[f]","FFT", bigtNames)
bigBodyNames <- gsub("BodyBody","Body", bigfNames, fixed=TRUE)
bigNoPeriods <- gsub("[.]","", bigBodyNames)
bigMeans <- gsub("mean","Mean", bigNoPeriods, fixed=TRUE)
bigGoodNames <- gsub("std","STD", bigMeans, fixed=TRUE)
########
### replace variable names in test and train
## make the header using colnames()
colnames(testDF) <-bigGoodNames
## make the header using colnames()
colnames(trainDF) <-bigGoodNames
########
### Combine the test and train data frames
## rbind testDF and trainDF
newDF <- rbind(testDF, trainDF)
newSubject <- rbind(subject_test, subject_train)
newY <- rbind(y_test, y_train)
########
### reduce dimensions
## subset only mean and sd columns from newDF using 'select' from dplyr
mstd <- select(newDF, contains("Mean"), contains("STD"))
########
## Make a name key that preserves original row numbers for 
## the names in the features file so we can know exactly
## which original names correspond to which newnames in
## the reduced dataframe of mean and std data
## The 'col#' column corresponds to the column# of the 
## original data frame [1:561] with the orignal and new names
reducedNames <- colnames(mstd)
newFeatures <- features
newFeatures$newNames <- bigGoodNames
## use dplyr 'filter'
nameKey <- filter(newFeatures, newNames %in% reducedNames)
colnames(nameKey) <- c("Col#", "originalName", "newName")
########
### add subject and activity vectors as columns to mstd data frame
## make vectors 
newActivityCode <- newY$V1
## extract vectors from activity data frame for keys in mapping values
activityNum <- activity$V1
activityName <- as.character(activity$V2)
## change activity codes to names using 'mapvalues' from plyr
namedActivities <- mapvalues(newActivityCode, activityNum, activityName)
newSubjectCode <- newSubject$V1
## add them to mstd data frame
combinedDF <- cbind(mstd, Activity = namedActivities, Subject = newSubjectCode)
## reorder columns to put activity and subject first
combinedDF <- combinedDF[c(88,87,1:86)]
########
### Aggregate and create the final tidy data set
AlmostTidyData <- group_by(combinedDF, Activity, Subject)
## the names of the columns you want to summarize
cols2 <- names(AlmostTidyData)
cols2 <- cols2[3:88]
## the dots component of your call to summarise
dots <- lapply(cols2, function(x) substitute(mean(x), list(x=as.name(x))))
tidyData <- do.call(summarise, c(list(.data=AlmostTidyData), dots))
########
### Write files
## Create Tidy Directory in Working Directory
dir.create("tidyFiles")
## Write File
write.table(tidyData, file="tidyFiles/tidyData.txt", row.name=FALSE)
## write nameKey
nameKey <- write.table(nameKey, file="tidyFiles/nameKey.txt", row.name=FALSE)
###########
#### END
###########



