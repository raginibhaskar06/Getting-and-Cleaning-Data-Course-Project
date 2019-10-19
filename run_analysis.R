# Features and Activities Reading from Files.
DS_Features <-  read.table("./UCI HAR Dataset/features.txt")
DS_activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# training datasets Reading from Disk
train_DS <- read.table("./UCI HAR Dataset/train/X_train.txt")

# Assigning the variable names.
colnames(train_DS) <- DS_Features$V2 

# Reading Activity labels
y_trainData <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_DS$activity <- y_trainData$V1

# Reading Subjects
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") #subjects
train_DS$subject <- factor(subject_train$V1)


#reading test data
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(testData) <- DS_Features$V2
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 
testData$activity <- y_test$V1
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testData$subject <- factor(subject_test$V1)

#merge train and test sets (STEP 1)
dataset <- rbind(testData, train_DS) 

#filter column names (STEP 2)
column.names <- colnames(dataset)
#get only columns for standard deviation and mean values, also saves activity and subject values 
column.names.filtered <- grep("std\\(\\)|mean\\(\\)|activity|subject", column.names, value=TRUE)
dataset.filtered <- dataset[, column.names.filtered] 

#adding descriptive values for activity labels (STEP 3)
dataset.filtered$activitylabel <- factor(dataset.filtered$activity, labels= c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#creating a tidy dataset with mean values for each subject and activity
features.colnames = grep("std\\(\\)|mean\\(\\)", column.names, value=TRUE)
dataset.melt <-melt(dataset.filtered, id = c('activitylabel', 'subject'), measure.vars = features.colnames)
dataset.tidy <- dcast(dataset.melt, activitylabel + subject ~ variable, mean)
                                         
#creating a tidy dataset file  
write.table(dataset.tidy, file = "tidydataset.txt" row.names = FALSE)
