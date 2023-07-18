setwd("path_to/Getting_and_Cleaning_data")
#Load the libraries
library(dplyr)
library(tidyr)

#Download and unzip the data
link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest <- "./galaxy_s.zip"
download.file(link, dest)
unzip("galaxy_s.zip", exdir = "./galaxy_s")


# PART1 - Merging Training and Test Data
# Read the training data
train_data <- read.table("./galaxy_s/UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("./galaxy_s/UCI HAR Dataset/train/y_train.txt")
train_subjects <- read.table("./galaxy_s/UCI HAR Dataset/train/subject_train.txt")
# Read the test data
test_data <- read.table("./galaxy_s/UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./galaxy_s/UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("./galaxy_s/UCI HAR Dataset/test/subject_test.txt")
# Merge the training and test datasets
merged_data <- rbind(train_data, test_data)
merged_labels <- rbind(train_labels, test_labels)
merged_subjects <- rbind(train_subjects, test_subjects)



# PART2 - Extract only the measurements on the mean and standard deviation for each measurement
# Read the features file
features <- read.table("./galaxy_s/UCI HAR Dataset/features.txt")
# Find the indices of the features containing mean and standard deviation
mean_std_indices <- grep("mean\\(\\)|std\\(\\)", features$V2)
# Extract the columns with mean and standard deviation measurements
x_extracted <- merged_data[, mean_std_indices]



# PART3 - Use descriptive activity names to name the activities in the data set
# Read the activity labels file
activity_labels <- read.table("./galaxy_s/UCI HAR Dataset/activity_labels.txt")
# Replace activity labels with descriptive names
activity_labels$V2 <- gsub("_", " ", tolower(as.character(activity_labels$V2)))
activity_names <- activity_labels[merged_labels$V1, 2]



# PART4 - Label the data set with descriptive variable names
# Clean up feature names
clean_feature_names <- gsub("\\(|\\)", "", features[mean_std_indices, 2])
colnames(x_extracted) <- clean_feature_names
# Create a combined data set with subject, activity, and extracted measurements
combined_data <- cbind(merged_subjects, activity_names, x_extracted)
# Replace Column Acronym with full name
names(combined_data)<-gsub("Acc", "Accelerometer", names(combined_data))
names(combined_data)<-gsub("Gyro", "Gyroscope", names(combined_data))
names(combined_data)<-gsub("BodyBody", "Body", names(combined_data))
names(combined_data)<-gsub("Mag", "Magnitude", names(combined_data))
names(combined_data)<-gsub("^t", "Time", names(combined_data))
names(combined_data)<-gsub("^f", "Frequency", names(combined_data))
names(combined_data)<-gsub("tBody", "TimeBody", names(combined_data))
names(combined_data)<-gsub("-mean()", "Mean", names(combined_data), ignore.case = TRUE)
names(combined_data)<-gsub("-std()", "STD", names(combined_data), ignore.case = TRUE)
names(combined_data)<-gsub("-freq()", "Frequency", names(combined_data), ignore.case = TRUE)
names(combined_data)<-gsub("angle", "Angle", names(combined_data))
names(combined_data)<-gsub("gravity", "Gravity", names(combined_data))
names(combined_data)



# PART5 - Creating a tidy data set with the average of each variable for each activity and each subject
tidy_data <- combined_data %>%
  group_by(V1, activity_names) %>%
  summarise(across(everything(), mean))
# Rename the variable to subject
colnames(tidy_data)[1] <- "Subject"
colnames(tidy_data)[2] <- "Activity Name"
# Write the tidy data to a file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)