# Course Project - Getting and Cleaning Data
## Breakdown of run_analysis.R

*The R script performs the following procedures:* 

### [0] Downloading data
1. Data was downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
2. Zip folder was unzipped and data sets in form of .txt files were read and stored to dataframes.

### [1] Merge training and test data sets
1. All train data sets were merged in one single dataframe - this includes data from X_train.txt, y_train.txt, subject_train.txt.
2. All test data sets were merged in one single dataframe - this includes data from X_test.txt, y_test.txt, subject_test.txt.
3. Resulting dataframes from Step 1 and 2 were combined to create the final dataframe.

### [2] Extract the measurements on the mean and standard deviation for each measurement
- Measurements which have "mean" and "std" string were extracted.

### [3]  Uses descriptive activity names to name the activities in the data set
- Activity names in the final dataframe (obtained in Section 1) were replaced with their descriptive names based on activity_labels.txt.

### [4] Label the data set with descriptive variable names
- The list generated in Step 2 was added as column names for the measurement data in the final dataframe.

### [5]  Create the tidy data set 
1. The final dataframe was grouped by Activity and Subject.
2. Mean for each group was obtained.
