cleaning_data
=============


run_analysis.R follows the 5 steps described in the project guidline. 


  Step1 consists of the code to import the data, lables and subjects from the training and test data sets.
The cbind function is used to create the test and train data sets consisting of data, lables and subjects. 
The rbind function is used to create the merged data set called combinedData. 


  Step 2 consist of the code to extract the mean and standard deviation for each measurement. 
First, the features.txt is imported to create the variable called features and the variable is set for the column names of the combinedData
created in Step1. The regular expression is applied for the features variable to extract logical values of mean and standard deviations for each 
measurement and such logical values are, then, assigned to the variable named featureMS. The featureMS varible is used to subset the columns
of the cokmbinedData to extact only required data set; the subset data set is renamed as the combinedData2.

  Step 3 consits of the code to create descriptive activity names for the column names of the combinedData2.
The activity_labels.txt is imported and is assitned to the variable called activity. The activity variable is 
assigned to the activity column of the combinedData2 using for loops.

  Step 4 consits of the code to modify the column names of the combinedData2 using regular expressions.

  Step 5 consists of the code to create a tidy data set composed of the average of each variable for each activity and each subject. 
group_by() and summarise_each() functions of the dplyr packages are used to aggregate the combinedData2. 
The aggregate data is assigned to the variable called data5 and data5 is converted into the dataframe format and 
is saved into the file named tidy_data.txt.

