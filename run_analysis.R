
#This script get
#It uses the dplyr package

library(dplyr)

#1.Dataset download
filename <- "Dataset.zip"
# Checking if archieve already exists.
if (!file.exists(filename))
  {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
  }  
# Check if the folder exists. If it does not, the file is unzipped
if (!file.exists("UCI HAR Dataset"))
  { 
  unzip(filename) 
  }
#2.Build the dataframes for features, activities, subject test, x test, y test, subject train
#x train and y train

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

#3. Merge the training and the test sets to create one data set.
#x train and test merged
X <- rbind(x_train, x_test)
#y train and test merged
Y <- rbind(y_train, y_test)
#all subjects merged
Subject <- rbind(subject_train, subject_test)
#all trains, tests and subjects merged
Merged_Data <- cbind(Subject, Y, X)

#4Extract only the measurements on the mean and standard deviation for each measurement.
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

#5. Use descriptive activity names to name the activities in the data set
#Set the TidyData code names to the activities names
TidyData$code <- activities[TidyData$code, 2]

#6. Appropriately label the data set with descriptive variable names.
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Mag", "magnitude", names(TidyData))
names(TidyData)<-gsub("Acc", "accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "gyroscope", names(TidyData))
names(TidyData)<-gsub("tBody", "timebody", names(TidyData))
names(TidyData)<-gsub("-mean()", "mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("BodyBody", "body", names(TidyData))
names(TidyData)<-gsub("angle", "angle", names(TidyData))
names(TidyData)<-gsub("gravity", "gravity", names(TidyData))
names(TidyData)<-gsub("^t", "time", names(TidyData))
names(TidyData)<-gsub("^f", "frequency", names(TidyData))
names(TidyData)<-gsub("-std()", "std", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "frequency", names(TidyData), ignore.case = TRUE)


#7. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyDataAgg <- aggregate(. ~subject + activity, TidyData, mean)
TidyDataAgg <- TidyDataAgg[order(TidyDataAgg$subject,TidyDataAgg$activity),]
write.table(TidyDataAgg, file = "TidyDataAgg.txt", row.names = FALSE)
