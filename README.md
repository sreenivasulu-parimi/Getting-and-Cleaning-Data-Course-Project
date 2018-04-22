# Getting-and-Cleaning-Data-Course-Project

It is a solution for the course (Getting and Cleaning Data) assignment called "Peer-graded Assignment: Getting and Cleaning Data Course Project" in Coursera. It contains a R script called 'run_analysis.R' which has all the required steps to getting, cleaning, transforming and summarizing the dataset in the required format as per the assignment.

Overview of the R script's execution:

* Downloadind and extracting the dataset if it does not already exist in the working directory.
* Read and Merges the training and the test sets to create one data set using data sets X_train, X_test, subject_train, subject_test, y_train, and y_test.
* Fetching only features/variables those containing either mean or standard deviation.
* Fetching the features/variables for each column and naming them in the merged data set.
* Appropriately labels the data set with descriptive variable names in the merged data set.
* Write the above merged data in to new file called 'merged_tidy_data.txt'.
* From the above merged data (merged_tidy_data.txt), creates a second, independent tidy data set 'averages_tidy_data.txt' with the average of each variable for each activity and each subject.
* The second data 'averages_tidy_data.txt' has dimension 180x68 since there are 30 subjects and 6 activities, thus, for each activity and each subject means 30 * 6 = 180 rows.