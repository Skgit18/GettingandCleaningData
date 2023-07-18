# Getting and Cleaning Data
Assignment: Getting and Cleaning Data Course Project

This project analyzes data collected from the accelerometers of the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data used for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
This project includes:
1. R script, **run_analysis.R**, which performs the following.
  - Merges the training and the test sets to create one data set.
  - Extracts only the mean and standard deviation indices for each measurement.
  - Uses descriptive activity names to name the activities in the data set.
  - Appropriately labels the data set with descriptive variable names.
  - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

2. A codebook, **CodeBook.md**,
  - Explains the R code by describing the processes involved in downloading, cleaning, and transforming the data.

3. A tidy data file, **tidy_data.txt**, created in the final step of **run_analysis.R**.
