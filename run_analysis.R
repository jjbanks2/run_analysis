
# Read files
# activity_labels<-read.table("activity_labels.txt", header=FALSE)
# features<-read.table("features.txt", header=FALSE)
# X_test<- read.table("./test/X_test.txt",header=FALSE)
# y_test<- read.table("./test/y_test.txt",header=FALSE)
# subject_test<- read.table("./test/subject_test.txt",header=FALSE)
# X_train<- read.table("./train/X_train.txt",header=FALSE)
# y_train<- read.table("./train/y_train.txt",header=FALSE)
# subject_train<-read.table("./train/subject_train.txt",header=FALSE)

# Appropriately label the dataset with descriptive variable names
colnames(activity_labels) <- c("Activity ID", "Activity")
colnames(features) <-c("Feature ID", "Feature")
colnames(X_test) <- c(features$Feature)
colnames(y_test) <-c("Activity")
colnames(subject_test) <-c("Subject ID")
colnames(X_train) <- c(features$Feature)
colnames(y_train) <- c("Activity")
colnames(subject_train) <- c("Subject ID") 


# Combine test and train data into one column (merge rows)
xtesttrain <- rbind(X_test, X_train)
ytesttrain <-rbind(y_test, y_train)
stesttrain <-rbind(subject_test, subject_train)

# Combine features, activity and subject columns for each measurement set
d<-cbind(stesttrain, ytesttrain, xtesttrain, stringsAsFactors=FALSE)

# Replace activity Id's with activity names
for (x in 1:length(d$Activity)) {
    if (d$Activity[x] == 1) {
        d$Activity[x] <- "walking"
    }
    if (d$Activity[x] == 2) {
        d$Activity[x] <- "walking upstairs"
    }
    if (d$Activity[x] == 3) {
        d$Activity[x] <- "walking downstairs"
    }
    if (d$Activity[x] == 4) {
        d$Activity[x] <- "sitting"
    }
    if (d$Activity[x] == 5) {
        d$Activity[x] <- "standing"
    }
    if (d$Activity[x] == 6) {
        d$Activity[x] <- "laying"
    }
}

# Extract measurements for mean & standard deviation for each measurement
msddata<-c(as.character(features$Feature[grep("mean\\(\\)|std\\(\\)", features$Feature)]))
msd<-d[, msddata]

# From the new dataset, create a second, independent
# tidy data set with the average of each variable for each
# activity and each subject.
newset<-cbind(msd, d$`Subject ID`, d$Activity)
tidy<-aggregate(newset, by=list(newset$`d$\`Subject ID\``, newset$`d$Activity`),
                FUN=mean)

# Rename new aggregate columns
colnames(tidy)[1]<-"Subject"
colnames(tidy)[2]<-"Activity"

# Delete legacy subject and activity columns
tidy<-tidy[,-69:-70]

# Variable name clean up
names(tidy)<-gsub("\\()", "", names(tidy))
names(tidy)<-gsub("^t", "time", names(tidy))
names(tidy)<-gsub("^f", "freq", names(tidy))

#Output file
write.table(tidy, "./tidy.txt", row.name=FALSE)



 