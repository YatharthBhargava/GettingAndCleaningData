# GettingAndCleaningData
##Codebook

Activities performed:
WALKING
, WALKING_UPSTAIRS
, WALKING_DOWNSTAIRS
, SITTING
, STANDING, LAYING



SubjectId - is the id of the ith person from whom the data was collected.



Only features having either mean() or std() were considered for tidying the dataset.



##Working of the script
1.Reading the features and storing it in a dataframe.
2.Reading the training and the testing data and renaming the columns as per the features.
3.Merging the training and testing set.
4.Renaming the first column as per the SubjectId and the last column as the activity being performed.
5.Assigning the value to its key pair in the activity column.
6.Factorising the Activities and the SubjectId column.
7.Using pipelining to find the mean of all the variables for a subjectid and activity pair.
8.Making a table which contains the tidy dataset. 