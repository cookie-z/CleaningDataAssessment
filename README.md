### Peer Assessments Introduction
*Getting and Cleaning Data
You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### FileList
1. run_analysis.R: main code
2. TidyData.txt :the tidy data set created in step 5 of the instructions

### My code work
1. Read files X_test,X_train.y_test,y_train,Subject_test,Subject_train,features and activity_lables text files into dataframes.
2. Column bind Dataframes y_test and subject_test and add column names Activity and Subject to it. ->datatesty
3. Column bind Dataframes y_train and subject_train and add column names Activity and Subject to it. ->datatrainy
and Replace activity numbers with Activity names from activity_lables.txt
4. Merge datatesty and datatrainy (dim-10299*2) ->totaly
5. Merge X_train and X_test data -> totaldata (dim-10299*561)
6. Change column names of totaldata from features.txt
7. Eliminate columns from totaldata which do not have "mean()" or "std()" in the column names. ->extrdata (dim-10299*66)
8. Column bind extrdata and totaly (dim-10299*68)
9. Take mean of observations per activity per subject. (dim-180*68). 
10. use write.table to get a text file from the above Data Frame.

