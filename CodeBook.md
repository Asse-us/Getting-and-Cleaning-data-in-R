
Codebook descriptions
=======================
# this code book describes the variables, the data, and the transformations or work that have been performed to clean up the row data.
# Two packages (data.table, dplyr) were installed and then the represented data were downloaded from the link provided in the project site. 
# project data link:- (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# The dataset is downloaded and extracted under directory "./Coursera-3.zip" and the zip file is unzipped with folder called "UCI HAR Dataset".
# The run_analysis.R script performs the data preparation and then followed by 5 steps required as described in the course project’s definition.
# The set of variables that were estimated from the signals are mean value (mean()) and standard deviation (std()) 

 variables and descriptions
=============================
# subject: ID of volunteers (ranging from 1 to 30) who performed various activities
# activity: the lists of six activities levels performed by volunteers (subject). these are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.
# features: reads table from features.txt : it has 561 observations and 2 variables namely n and functions. The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
# activities: reads table from activity_labels.txt : it has 6 rows, 2 columns namely class_label and activity. it shows the list of activities performed when the corresponding measurements were taken and its codes (class_labels).
# testsubject: reads test/subject_test.txt. It has 2947 rows and 1 column. Each row identifies the subject who performed the activity.
# testingSets: test/X_test.txt : 2947 rows, 561 columns. It contains recorded features test data for each pattern.
# testLabels: test/y_test.txt : 2947 rows, 1 columns it contains test data of activities’class labels.
# trainingSubjects: test/subject_train.txt : 7352 rows, 1 column. It contains training data of volunteer subjects being observed.
# trainingSets: test/X_train.txt : 7352 rows, 561 columns. It contains recorded features training data
# trainingLabels: test/y_train.txt : 7352 rows, 1 columns. It contains train data of activities’code labels

 The following steps were performed for this particular project
================================================================
# 1. Merges the training and the test sets to create one data set
  # The following sets were merged using rbind () function for the first three and cbind() function     for the last one.
	# T_sets (10299 obs, 561 variables) is created by merging trainingsets and testingsets. 
	# T_labels (10299 obs, 1 variable) is created by merging traininglabels and testinglabels
	# Subject (10299 obs, 1 variable) is created by merging traininSubjects and testSubject.
	# combined_Data (10299 obs, 563 variables) is created by merging Subject, T_labels and T_sets. 

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
  # TidyData (10299 obs, 88 variables) is created by subsetting combined_Data with selection of subject, class_label and the mean and standard deviation 		(std) for each measurement.

# 3. Uses descriptive activity names to name the activities in the data set
	Entire numbers in class_label column of the TidyData replaced with corresponding activity taken from second column of the activities variables.
# 4. Appropriately labels the data set with descriptive variable names class_label column in TidyData renamed into activities
	# All Acc in column’s name is replaced by Accelerometer.
	# All Gyro in column’s name is replaced by Gyroscope.
	# All BodyBody in column’s name is replaced by Body.
	# All Mag in column’s name is replaced by Magnitude.
	# All tBody in column's name is replaced by TimeBody
	# All start with character f in column’s name replaced by Frequency.
	# All start with character t in column’s name replaced by Time.
	# All gravity in column's name is replaced by Gravity.
	# All angle in column's name is replaced by Angle.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
	# TidyDataSet (180 obs, 88 variables) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.

 TidyDataSet Export
=======================
# The TidyDataSet is exported as a txt file created with write.table() using row.name=FALSE with a file name Tidy_Data_Set.txt file. The data set also staged and pushed to my GitHub repository.

