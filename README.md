Getting and Cleaning Data Course Project
========================================
Course project for "Getting and Cleaning Data"

Files
------
* /test and /train contain raw movement data.
* tidy.txt contains averages for average and standard deviation columns from the raw data, grouped by subject and activity.
* run_analysis.R is an R script to generate the tidy data from the raw data.

run_analysis.R
--------------
Relies on the dplyr library.

The function *loaddata* loads raw data from a given subdirectory ("test" or "train"), keeping only variables that are an average or a standard deviation, into a data frame. It then adds to the data frame the activity name and the subject.

The function *runanalysis* uses the above function to load both test and train data from the two respective subdirectories and combines the two data frames. Then, it creates a new data frame, grouped by subject and activity. Finally, it creates a summary data frame, taking the average of every variable, for each subject and activity.

The file tidy.txt included here is the result of calling write.table on the output of runanalysis.
