Code Book - run_analysis.R
Jennifer Banks
November 6, 2023

Dataset:

Data collected from the accelerometers from the Samsung Galaxy S smartphone.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Full description at site where data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Initial files/datasets:
All files imported with no column names, names in this section are for initial general description purposes

README.txt:  txt file providing description of all data files

activity_labels.txt:  txt file with 2 cols and 6 rows, activity ID and activity name

features.txt:  txt file with 2 cols and 561 rows, features ID and feature name

X_test.txt:  txt file with 561 cols, 2947 rows of measurement data

y_test.txt:  txt file with 1 col, 2947 rows of activity IDs

subject_test.txt:  txt file with 1 col, 2947 rows of subject IDs

X_train.txt:  txt file with 561 cols, 7352 rows of measurements data

y_train.txt:  txt file with 1 col, 7352 rows of activity IDs

subject_train.txt: txt file with 1 col, 7352 rows of subject IDs

Assigned the following variables to the above datasets:
activity_labels.txt:  Activity ID, Activity
features.txt:  Feature ID, Feature
X_test.txt: features.txt$Feature (for 561 columns)
y_test.txt:  Activity
subject_test.txt:  Subject ID
X_train.txt:  features.txt$Feature (for 561 columns)
y_train.txt:  Activity
subject_train.txt:  Subject ID

Initial data merge into master dataset:
Performed rbind on X_test and X_train to produce xtesttrain, with 561 columns (feature names), and 10299 rows
Performed rbind on y_test and y_train to produce ytesttrain, with 1 column (Activity ID) and 10299 rows
Performed rbind on subject_test and subject_train to produce stesttrain, with 1 column (Subject ID), and 10299 rows
Performed cbind on xtesttrain, ytesttrain and stesttrain, to produce new dataset d, with 563 columns and 10299 rows

Revised data in column d$Activity to refer to activity name, rather than activity ID, using a for loop and the information provided in acitivity_labels.

From the d dataset, the mean and standard deviation were extracted using grep to create a new dataset msd, containing only the mean and standard deviation for the individual measurements.  msd contains 66 columns and 10299 rows.

From the msd dataset, a new tidy data set "tidy" was created with the average of each variable for each activity and each subject, using the aggregate function, grouping by Subject ID and Activity variables, and using the mean function.  Tidy contained 70 columns and 180 rows.

Clean up was then performed on dataset tidy as follows:
Renamed the new group by columns to "Subject" and "Activity" using colnames().
Deleted the previous Subject and Activity columns by deleting the last two columns of tidy.
Performed column name clean up by use of gsub, deleting extraneous parenthesis, changing abbreviation "t" to "time" and abbreviation "f" to "freq" at the beginning of the feature name variables.

Final dataset:  Tidy, containing 68 columns and 180 rows, exported through write.table function to file "tidy.txt" in the working directory.