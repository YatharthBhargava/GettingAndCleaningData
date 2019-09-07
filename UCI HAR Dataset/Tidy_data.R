df_features <- read.table("features.txt")
feature_names <- df_features[,2]

setwd("train/")
df_subject_train <- read.table("subject_train.txt")
df_x_train <- read.table("X_train.txt")
colnames(df_x_train) <- feature_names
df_x_train_mean_std <- df_x_train[,grep("mean()|std()",colnames(df_x_train))]
df_y_train <- read.table("y_train.txt")
setwd("..")

setwd("test/")
df_subject_test <- read.table("subject_test.txt")
df_x_test <- read.table("X_test.txt")
colnames(df_x_test) <- feature_names
df_x_test_mean_std <- df_x_test[,grep("mean()|std()",colnames(df_x_test))]
df_y_test <- read.table("y_test.txt")
setwd("..")

merged_training_set <- cbind(df_subject_train,df_x_train_mean_std)
merged_training_set <- cbind(merged_training_set, df_y_train)
merged_testing_set <- cbind(df_subject_test,df_x_test_mean_std)
merged_testing_set <- cbind(merged_testing_set,df_y_test)
merged_dataset <- rbind(merged_training_set,merged_testing_set)

colnames(merged_dataset)[81] <- "Activity"
colnames(merged_dataset)[1] <- "SubjectId"
merged_dataset$Activity <- as.character(merged_dataset$Activity)
merged_dataset$SubjectId <- as.character(merged_dataset$SubjectId)

for (i in 1:10299) {
  if(merged_dataset$Activity[i] == "1"){ merged_dataset$Activity[i] = "Walking"}
  else if(merged_dataset$Activity[i] == "2"){merged_dataset$Activity[i] <- "Walking Upstairs"}
  else if(merged_dataset$Activity[i] == "3"){merged_dataset$Activity[i] <- "Walking Downstairs"}
  else if(merged_dataset$Activity[i] == "4"){merged_dataset$Activity[i] <- "Sitting"}
  else if(merged_dataset$Activity[i] == "5"){merged_dataset$Activity[i] <- "Standing"}
  else if(merged_dataset$Activity[i] == "6"){merged_dataset$Activity[i] <- "Laying"}
}

for(i in 1:10299){
  merged_dataset$SubjectId[i] <- paste("SubjectNo.",merged_dataset$SubjectId[i])
}

merged_dataset$SubjectId <- as.factor(merged_dataset$SubjectId)
merged_dataset$Activity <- as.factor(merged_dataset$Activity)

Tidy_dataset <- merged_dataset %>%
       group_by(SubjectId,Activity) %>%
       summarize_each(funs(mean))

write.table(Tidy_dataset,"TidyData.txt",row.names = F,quote = F)