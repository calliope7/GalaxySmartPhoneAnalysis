# Analyse the Accelerometer Data from a Samsung Galaxy S

# This script does the following:
# 1) downloads the data set in zip format to a 'dir' directory under the directory where its run
# 2) names the file with a timestamp so that further runs will not overwrite and well have a record of when the data was downloaded
# 3) Extracts summary files from the test and train directories as well as activity labels and feature names
# 4) leverages the above files to:
#       a) extract all mean and standard deviation measurements in both data sets
#       b) label activities with names from the activity_labels.txt file
#       c) label dataset observations by extracting names from the features.txt file and removing unwanted control characters: '-', '(', ')'
#          which cause problems with data.table manipulation
#       d) This leaves two data sets: trainingSet and testSet.
#       e) Each observation in the two sets are then marked with the boolean 'isTraining' according to their type
#       f) The sets are merged and keyed by 'user' and 'activity' resulting in a data.table called 'mergedSet'
#       g) Finally we average each observation over each 'user','activity' combination and save the results in the 'aveSet' data.table.
#          In this case the 'isTraining' column is also removed because it becomes meaningless in this context.


library(data.table)

# data url
zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDir <- "./data/"
dataSetDir <- paste(dataDir, "UCI HAR Dataset", sep="")

# prep: download file and store in data dir
# returns the scoped name of the zip file to use for extraction
downloadFile <- function(zipURL, dataDir) {
        if (!file.exists("data")) {
                dir.create("data")
        }
        zipFileName <- "Dataset.zip"
        # always download fresh set and capture data
        dateDownloaded <- format(Sys.time(), "%y-%m-%d.%H-%M-%S")
        fileNameResult <- paste(dataDir, dateDownloaded, zipFileName, sep="-")
        download.file(zipURL, destfile=fileNameResult, method="curl") 
        fileNameResult
}

# returns a data set reflecting the internal file path
# TODO: clean this up.. reads file but
getDataSetWithin <- function(zipFileName, path) {
        con <- unz(zipFileName, path)
        data <- data.table(read.table(con))
}

# 0.) Load main data set
zipFileName <- downloadFile(zipURL, "./data/")
activityLabels <- getDataSetWithin(zipFileName, "UCI HAR Dataset/activity_labels.txt")
features <- getDataSetWithin(zipFileName, "UCI HAR Dataset/features.txt")
setkey(features, V2)
meanStdFeatures <- features[grep("mean|std", V2),]
featureNames <- levels(meanStdFeatures[,V2][1])

# 1.) Merge training and test sets to create one data set
# 2.) Extract only the measurements on the mean and std for each measurement
# 3.) Uses descriptive activity names to name the activities in the data set
# 4.) Appropriately label the data set with descriptive variable names

# grab training
trainingSet <- getDataSetWithin(zipFileName, "UCI HAR Dataset/train/subject_train.txt")
setnames(trainingSet,"user")
yTrain <- getDataSetWithin(zipFileName, "UCI HAR Dataset/train/y_train.txt")
xTrain <- getDataSetWithin(zipFileName, "UCI HAR Dataset/train/X_train.txt")
trainingSet[, activity := activityLabels[yTrain[,V1], "V2", with=FALSE]]
xTrainMeanStd <- xTrain[,meanStdFeatures[,V1], with=FALSE]
for (i in 1:ncol(xTrainMeanStd)) {
        trainingSet[, featureNames[meanStdFeatures[,V2][i]] := xTrainMeanStd[,i, with=FALSE]]
}

# now grab test
testSet <- getDataSetWithin(zipFileName, "UCI HAR Dataset/test/subject_test.txt")
setnames(testSet,"user")
yTest <- getDataSetWithin(zipFileName, "UCI HAR Dataset/test/y_test.txt")
xTest <- getDataSetWithin(zipFileName, "UCI HAR Dataset/test/X_test.txt")
testSet[, activity := activityLabels[yTest[,V1], "V2", with=FALSE]]
xTestMeanStd <- xTest[,meanStdFeatures[,V1], with=FALSE]
for (i in 1:ncol(xTestMeanStd)) {
        testSet[, featureNames[meanStdFeatures[,V2][i]] := xTestMeanStd[,i, with=FALSE]]
}

# Merging seems a bit weird!  Since one is training and one is test you would think they should be kept separate
# even if merged.. but from the instructions, we'll want to aggregate.  I'm choosing to merge and add a flag to 
# each observation to tell if it is training or test: call it 'isTraining'
trainingSet[, isTraining := TRUE]
testSet[, isTraining := FALSE]

# mergedSet is really the place to start for further analysis - we can now differentiate between training and test sets.
mergedSet <- rbind(trainingSet, testSet)
# clean up names
names2 <- sapply(names(mergedSet), function(x){gsub("[-()]+", ".",x)})
setnames(mergedSet, names2)


# 5.) from dataset in 4 create a second, independent tidy data set with the average 
#     of each variable for each activity and each subject.
setkey(mergedSet, user, activity)
aveSet <- mergedSet[, lapply(.SD, mean), by=.(user, activity)]
# tidy up by dropping the isTraining column which is meaningless when we take the average
aveSet[, isTraining:=NULL]
 
# finally write out target file with averages across mean and std fields
write.table(aveSet, file="SamsungGalaxyMeanStdResults.txt", row.names=FALSE)
