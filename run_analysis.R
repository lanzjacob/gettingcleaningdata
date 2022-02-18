library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./courseproj.zip")
list.files(".")

unzip("./courseproj.zip")

##0. Stores all data in the zip file to R data frames
activity_labels_df <- read.table("./UCI HAR Dataset/activity_labels.txt")
features_df <- read.table("./UCI HAR Dataset/features.txt")

X_train_df <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train_df <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                         col.names = "Activity")
subject_train_df <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                               col.names = "Subject")

X_test_df <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test_df <- read.table("./UCI HAR Dataset/test/y_test.txt",
                        col.names = "Activity")
subject_test_df <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                              col.names = "Subject")

##1. Merges the training and the test sets to create one data set

#Get the columns which have "mean" and "std" 
mean_std_list <- grep(".mean|std.", as.character(features_df$V2))

#Merge all train sets
train_df <- cbind(subject_train_df, y_train_df, X_train_df[,mean_std_list])
#Merge all test sets
test_df <- cbind(subject_test_df, y_test_df, X_test_df[,mean_std_list])
#Merge the training and test sets
merged_df <- rbind(train_df, test_df)

##2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#Create list of measurements with "mean" and "std"
col_labels <- features_df[mean_std_list,2]
col_labels <- gsub("-","",col_labels)
col_labels <- gsub("mean","Mean",col_labels)
col_labels <- gsub("std","Std",col_labels)
col_labels <- gsub("[()]","",col_labels)

##3. Uses descriptive activity names to name the activities in the data set
merged_df$Activity <- activity_labels_df$V2[merged_df$Activity]

##4. Appropriately labels the data set with descriptive variable names.
colnames(merged_df) <- c("Subject","Activity",col_labels)

##5. From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.
tidy_dataset_df <- merged_df %>% group_by(Activity, Subject) %>% summarise_all(mean)

write.table(tidy_dataset_df, "tidy_data_set.txt", row.names=FALSE)

