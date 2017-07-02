library(plyr)
## loading the Training data 
##data
trainXdata <- read.table("./UCI HAR Dataset/train/X_train.txt")
##labels
trainYlabels <- read.table("./UCI HAR Dataset/train/y_train.txt")
##Subjects Involved
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
## loading the test data
##data
testYdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
##labels
testYlabels <-  read.table("./UCI HAR Dataset/test/y_test.txt")
## Subjects involved
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")

##loading the  features & labels
labelsval <- read.table("./UCI HAR Dataset/activity_labels.txt") 
features <- read.table("./UCI HAR Dataset/features.txt")
## to verify the dimensions of training and test data sets
dim(trainXdata)
dim(trainYlabels)
dim(trainSubjects)
dim(features)
head(features,2)

##STEP 2 :  To extract features with mean and standard deviation values 
meanFeatures <- features[grep(c("mean"),features$V2),]
stdFeatures <- features[grep(c("std"),features$V2),]
meanstdFeatures <-  rbind(meanFeatures,stdFeatures)

## to verify the dimensions of newly structured dataframes
dim(stdFeatures)
dim(meanFeatures)
dim(meanstdFeatures)
meanstdFeatures

##to select only required columns ( Mean& std ) in the training and test sets 
colvalues = as.vector(meanstdFeatures$V1)
trainXdata = trainXdata[,colvalues]
testYdata = testYdata[,colvalues]
features = features[ ,colvalues]
colvalues
## selecting only required features
features <- merge(features,meanstdFeatures,by = "V1")
features <- select(features,V1:V2.x)
dim(features)
## verifying the dimensions of required data sets 
dim(colvalues)
dim(trainXdata)
dim(trainYlabels)
dim(trainSubjects)
dim(testYdata)
dim(testYlabels)
dim(testSubjects)

## STEP 1 : combine the data,labels and subject for each data sets. 
traindata = cbind(trainYlabels,trainSubjects,trainXdata)
testdata = cbind(testYlabels,testSubjects,testYdata)
## verifying data
dim(traindata)
head(traindata,3)
dim(testdata)
head(testdata,3)

##  STEP 4 :Properly naming the  variable with descriptive names 
names <- c("activity","subjects", as.vector(features$V2.x))
names
colnames(traindata) <- names
colnames(testdata) <- names
tidy_data <- rbind(traindata,testdata)

## STEP 3 : Properly naming the activity
tidy_data[, 1] <- labelsval[tidy_data[, 1], 2]

## STEP 5 : creating an independent data set with average of each variable for each activity and subject
independent_data <- ddply(tidy_data, .(subjects, activity), function(x) colMeans(x[, 2:81]))
write.table(independent_data,file = "tidy_dataset.txt",row.names = FALSE)
independent_data

       






