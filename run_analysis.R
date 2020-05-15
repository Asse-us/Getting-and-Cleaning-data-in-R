
# load the packages and load the data from the web link.
install.packages("data.table", "dplyr")
packages<- c("data.table", "dplyr")
lapply(packages, library, character.only = TRUE)

filename <- "Coursera3_proj.zip"
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, filename, method="curl")

unzip(filename) 

# lets check the zip file and the new folder that has been unzipped
path<- getwd()

# defining the path for the unzipped folder and creating a new file contaning all the files names.
rowdatapath <- file.path(path, "UCI HAR Dataset")
rowdatasets <- list.files(rowdatapath, recursive=TRUE)

#Check and see the lists of the files in the row data set
rowdatasets

# There are 28 files and that need to be analyzed

# ASSIGNING ALL THE DATA FRAMES AND READING THE FILES

# Load activity labels and features
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("class_label", "activity"))

# load the testing data (X_test, Y_test, subject_test files)
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
testingSets <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "class_label")

# Load training data (X_train, Y_train, subject_train files)
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
trainingSets <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
trainingLabels <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "class_label")

# STEP-1: Merges the training and the test sets to create one data set.
T_sets <- rbind(trainingSets, testingSets)
T_labels <- rbind(trainingLabels, testLabels)
Subject <- rbind(trainingSubjects, testSubjects)
combined_Data <- cbind(Subject, T_labels, T_sets)

# STEP-2: Extracts only the measurements on the mean and standard deviation for each measurement.
TidyData <- combined_Data %>% select(subject,class_label , contains("mean"), contains("std"))

# STEP-3: Uses descriptive activity names to name the activities in the data set.
TidyData$class_label <- activities[TidyData$class_label, 2]

# STEP-4: Appropriately labels the data set with descriptive variable names.
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))


# STEP-5: From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
TidyDataSet <- TidyData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(TidyDataSet, "Tidy_Data_Set.txt", row.name=FALSE)
