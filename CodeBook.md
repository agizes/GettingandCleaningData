# Code Book

This code book describes the variables, source data data and transformations done to clean up the data for the Getting and Cleaning data 

## Dataset Information

Data correspond to experiments within a group of people who have performed six different activities:
- Walking
- Walking upstairs
- Walking dowsntairs
- Sitting
- Standing
- Laying

These activities werea measured with a smartphone the participants wore during the experiment.

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for 
generating the training data and 30% the test data. 

## Source Data

- [Data description]http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
- [Source of data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Files

- `README.txt`: contains general information of the experiment
- `features_info.txt`: contains information about the variables used
- `features.txt`: contains the list of all features
- `activity_labels.txt`: contains links the class labels with their activity name
- `train/X_train.txt`: training set data
- `train/y_train.txt`: training labels
- `test/X_test.txt`: test set data
- `test/y_test.txt`: test labels

Files in the "train" and "test" subfolders contain the same type of information structure: (xxx corresponds to train or test)
- `xxx/subject_train.txt`: Each row refers to each person who performed the activity for each window sample. 
- `xxx/Inertial Signals/total_acc_x_train.txt`: The acceleration signal from the smartphone accelerometer X axis in standard  gravity units 'g'. 
Each row shows a `128` element vector. The same description applies for the `total_acc_x_train.txt` and for the `total_acc_z_train.txt` files for 
the Y and Z axis.
- `xxx/Inertial Signals/body_acc_x_train.txt`: The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- `xxx/Inertial Signals/body_gyro_x_train.txt`: The angular velocity vector measured by the gyroscope for each window sample. 
These values are expressed in `radians-per-second`. 

## Data Manipulation details

The `run_analysis.R` script performs the following actions towards the final clean dataset:
1. Download the dataset
2. Build the basic dataframes
3. Merge the training and the test sets to create one data set.
4. Extract only the measurements on the mean and standard deviation for each measurement
5. Use descriptive activity names to name the activities in the data set
6. Appropriately label the data set with descriptive variable names
7. From the data set in step 6, create a second, independent tidy data set with the average of each variable for each activity and each subject.

### 1. Download the dataset
The first step is to validate if the file / directory exists. If it does not, it downloads the file, creates the directory and unzips the file

### 2.Build basic dataframes
This step builds the basic dataframes for features, activities, subject test, x test, y test, subject train, x train and y train

### 3.  Merge the training and the test sets to create one single data set
* Merged_Data: X_test.txt and X_train txt merge. Datraframe with 10299 observations and 561 variables
* Subjects: Subject_test and Subject_train merged. Dataframe with 10299 observations

### 4. Extract only the measurements on the mean and standard deviation for each measurement
This piece of code generates selects only the mean and standard deviation from the merged data.
The output is a dataframe with 10299 observations and 66 variables.

### 5. Use descriptive activity names to name the activities in the data set
In this step we set the TidyData code names to the activities names, inserting into the the $code variable the activity codes from
activity_lables.txt.Explecitely this corresponds to:
- Walking
- Walking_upstairs 
- Walking_downstairs
- Sitting
- Standing
- Laying

### 6. Appropriately labels the data set with descriptive variable names
The script renames the the dataset columns with descriptive names:
- The column corresponding to activities is renamed to "activity"
- "Mag" is transformed to "magnitude"
- "Acc", is transformed to "accelerometer"
- "Gyro", is transformed to "gyroscope",
- "tBody", is transformed to "timebody"
- "-mean()" is transformed to "mean"
-"BodyBody" is transformed to  "body"
-"angle" is transformed to  "angle"
-"gravity" is transformed to  "gravity"
-"^t" is transformed to  "time"
- "^f" is transformed to  "frequency"
- "-std()" is transformed to "std"
- "-freq()" is transformed to  "frequency"

### 7. Create the Tidy Dataset
The last step is to generate a second "aggregated" dataset with the average of each measurement grouped for each activity and subject.
The result is saved in the "TidyDataAgg.txt" file.
