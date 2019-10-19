**"Getting and Cleaning Data"** Course Project
========================================

## Initial data for research
This script is developed to analyze the dataset available from [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
The data has been extracted to working directory of the project.

Datasets used :
1) Features.txt 		--> Descriptions of features measured.
2) train/X_train.txt	--> measurements of Train dataset features.
3) test/X_test.txt		--> measurements of Test dataset features. 
4) train/subject_train.txt --> subject for each measurement from the train set
5) test/subject_test.txt   --> subject for each measurement from the test set
6) train/y_train.txt --> activity (from 1 to 6) for each measurement from the train set
7) test/y_test.txt	 --> activity (from 1 to 6) for each measurement from the test set

## How script works
Script involves the following stages:

1. Read all descriptions of the features measured from features.txt.

2. Load data for train and test sets.   
    a. loads the measurements from X_train.txt as a data frame  
    b. column names are updated to be more user friendly using features description. 
		(**STEP 4**: *Appropriately label the data set with descriptive variable names* of Course Project)  
    c. activity labels and subjects for measurements are also loaded from files train/y_train.txt and train/subject_train.txt and added to data frame as a separated columns.
  
  Similar steps are made for test dataset and finally 2 rows of 2 data frames are merged together to form are data frame with complete data 
	(**STEP 1**: *Merge the training and the test sets to create one data set* of assignment)

3. To extract measurements that involves only mean and standard deviation values script uses grep, that finds column names that includes "mean()" or "std()" 
	After that all new data frame with only necessary columns is created. 
	(**STEP 2**: *Extract only the measurements on the mean and standard deviation for each measurement* of assignment)

4. To provide descriptive values for activity labels a new variable *"activitylabel"* is added to dataset, that is a factor variable with levels mentioned in file activity_labels.txt 
	(**STEP 3**: *Use descriptive activity names to name the activities in the data set* of assignment)

5. Creates a melted data frame using activity label and subject as ids, after that mean values for all variables are calculated grouped by activity and subject using dcast() function and tidy data frame is created. 
	(**STEP 5**: *Create a second, independent tidy data set with the average of each variable for each activity and each subject*)
