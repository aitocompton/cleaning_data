#### Step1: Merges the training and the test sets to create one data set.


	# create the dataframes for the training and test labels. 

	trainLabel  <- read.table("Downloads/UCI HAR Dataset/train/y_train.txt")

	testLabel  <- read.table("Downloads/UCI HAR Dataset/test/y_test.txt")

	# create the dataframes for the training and test data. 

	testData  <- read.table("Downloads/UCI HAR Dataset/test/X_test.txt")

	testLabel  <- read.table("Downloads/UCI HAR Dataset/train/X_train.txt")

	# create the dataframes of subjects for test and trian data.
	
	testSub <- read.table("Downloads/UCI HAR Dataset/test/subject_test.txt")
	
	trainSub <- read.table("Downloads/UCI HAR Dataset/train/subject_train.txt")
 

	# combine the label, subjects and data for test and training. 


	test <- cbind(testLabel, testSub,  testData)

	train <- cbind(trainLabel, trainSub, trainData)

	# combine the test and training dataframe. 

	combinedData <- rbind(train , test)


### Step2: Extracts only the measurements on the mean and standard deviation for each measurement. 
 
	# create the vector for feature names used for the column names for the combinedData

	features <- read.table("Downloads/UCI HAR Dataset/features.txt",stringsAsFactors=F)

	features<-features[,2]

	# modify the column data of combinedData to the features data. 

	colnames(combinedData)[-c(1,2)]<-features

	colnames(combinedData)[c(1,2)]<-c("activity","subject")

	# extract the data related to mean() and std() from the features data.

	featuresMS<-grepl(".*mean\\(\\).*|.*std\\(\\).*",features) 

	# extract the measurements on mean() and std() for each measurement. 

	combinedData2 <- combinedData[,c(T,T,featuresMS)]

### Step3: Uses descriptive activity names to name the activities in the data set 
	# create the data with the activity names.

	activity <- read.table("Downloads/UCI HAR Dataset/activity_labels.txt",stringsAsFactors=F)

	# create a column that matches the names of the activities with the inters of the combinedData2.

	for(i in 1:length(combinedData2[,1])){
		for (j in 1:length(activity2)){
			if (combinedData2[i,1]==activity[j,1]){
				combinedData2$activity[i]<-activity[j,2]
			}
		}	
	}

## Step4: Appropriately labels the data set with descriptive variable names. 
	# create the descriptive column names for combinedDat2

	colNames <-tolower(sub("^t","time_",colnames(combinedData2)))

	colNames<-sub("^f","frequency_",colNames)

	colNames <- sub("acc","_accelerometer_",colNames)

	colNames <- sub("gyro","_gyroscope_",colNames)

	colNames <- sub("mag","_magnitude_",colNames) 


	colNames <- sub("-mean\\(\\)", "_mean", colNames)

	colNames <- sub("-std\\(\\)", "_standard_deviation", colNames)

	colNames <- gsub("__","_",colNames)

	colNames <- gsub("-","_",colNames)

	colNames<-sub("bodybody","body",colNames)

	colnames(combinedData2)<-colNames


## Step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	data5<- combinedData2 %.% group_by(activity, subject) %.% summarise_each(funs(mean))


	# transform the activiy column with integers into characters.

	for(i in 1:length(data3[,1])){
		for (j in 1:length(activity2)){
			if (data3[i,1]==activity[j,1]){
				data3$activity[i]<-activity[j,2]
			}	
		}
	}

	# modify data5 into dataframe.
	
	data5 <- as.data.frame(data5)
	
	# create the text file for data5

	write.table(data5, "tidy_data.txt",row.name = F, sep="\t")
	
	# output data5
	
	data5
