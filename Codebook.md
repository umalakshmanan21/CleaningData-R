
## Introduction

### library added : `plyr`

The main file Run_Analysis consists of code to get and clean the data from UCI Machine learning repository. 
A run through of a code in the file is as follows. 
Initially the data is downloaded from the UCI Machine learning repository by using `download.file()`. 
Each of the data sets in txt file is then read to seperate data frames. 
Then the measurements on mean and std for each measurement is extracted from all the files(test, training and features file)

The data,labels and subjects for training and test datasets are binded together using `cbind()`. 
The variables and activities are labelled and both test and training data sets are binded together to form one data set using `rbind`.

Finally, the dataset is grouped by subjects and activity using `group_by` , and the average measurements for each group is extracted to a separate tidy data set by using `colMean()` in `ddply` function



## variables : 
`trainXdata`  , `trainYlabels`, `trainSubjects`, `testYdata`, `testYlabels`, `testSubjects`,`labelsval`, `features` - the training data , test data their activities, subjects and features.

`traindata`,`testdata` contains the all the data inclusive of activites and subjects for test and training data respectively

`tidy_data` contains the overall data set containing both test and training data 

`independent_data` contains the average measurement for each group , groupby subjects and activity.
