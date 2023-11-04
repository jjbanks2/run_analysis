# Merges the training and the test sets to create one data set.
# 
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# 
# Uses descriptive activity names to name the activities in the data set
# 
# Appropriately labels the data set with descriptive variable names. 
# 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#read files

#2 cols, V1 and V2?, Activity ID, Activity Name
activity_labels<-read.table("activity_labels.txt", header=FALSE)

# 561 cols, 2947 rows. of measurement data.  Cols V1 etc
X_test<- read.table("./test/X_test.txt",header=FALSE)

# 1 col, Activity ID
y_test<- read.table("./test/y_test.txt",header=FALSE)

# 1 col, 1-24, Subject ID?
subject_test<- read.table("./test/subject_test.txt",header=FALSE)

# 561 cols, 7352 rows, measurement data
X_train<- read.table("./train/X_train.txt",header=FALSE)

# 1 col, Activity ID
y_train<- read.table("./train/y_train.txt",header=FALSE)

# 1 col, Subject ID?
subject_train<-read.table("./train/subject_train.txt",header=FALSE)