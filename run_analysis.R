################################################################################################
##                      Assignment: Getting and Cleaning Data Course Project
################################################################################################
#https://devpost.com/software/getting-and-cleaning-data-course-project
#https://github.com/nikhilprathapani/Getting-and-Cleaning-Data-Course-Project

#Data Source:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


                       # This R script does the following:


# Download and unzip the data:
filename <- "getdata_dataset.zip"

if (!file.exists(filename)) {
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, filename, method="curl")
}

if (!file.exists("UCI HAR Dataset")) {
      unzip(filename)
}
                  
###
###   1. Merges the training and the test sets to create one data set.
###
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X <- rbind(X_train, X_test)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
Subject <- rbind(subject_train, subject_test)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
Y <- rbind(y_train, y_test)


###
###   2. Extracts only the measurements on the mean and standard deviation for each measurement.
###
features <- read.table("UCI HAR Dataset/features.txt")
mean_std_features_indices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, mean_std_features_indices]
names(X) <- features[mean_std_features_indices, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))
###
###   3. Uses descriptive activity names to name the activities in the data set.
###
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

###
###   4. Appropriately labels the data set with descriptive variable names.
###
names(Subject) <- "subject"
merged_tidy_data <- cbind(Subject, Y, X)
write.table(merged_tidy_data, "merged_tidy_data.txt")

###
###   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###
unique_sub <- unique(Subject)[,1]
len_sub <- length(unique_sub)
len_act <- length(activities[,1])
num_cols <- dim(merged_tidy_data)[2]
result <- merged_tidy_data[1:(len_sub*len_act),]
row <- 1
for (s in 1:len_sub) {
      for (a in 1:len_act) {
            result[row, 1] <- unique_sub[s]
            result[row, 2] <- activities[a, 2]
            tmp <- merged_tidy_data[merged_tidy_data$subject==s & merged_tidy_data$activity==activities[a, 2],]
            result[row, 3:num_cols] <- colMeans(tmp[, 3:num_cols])
            row <- row+1
      }
}
write.table(result, "averages_tidy_data.txt")