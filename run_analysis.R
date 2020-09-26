library(dplyr)
fname <- "Coursera_Final.zip"

#Check if file exists
if(!file.exists(fname)){
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(URL, fname, method="curl")
}

#Check if folder exists
if (!file.exists("UCI HAR Dataset")){
  unzip(fnames)
}

#Read Tables with features

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merge training and test data sets.

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
sub <- rbind(subject_train, subject_test)
data <- cbind(sub, y, x)

#Obtain measurements that contain mean and standard dev.

tidy <- data %>% select(sub, code, contains('mean'), contains('std'))

#Describe columns for activities

tidy$code  <- activities[tidy$code, 2]
names(tidy)[2] = "activity"
names(tidy)<-gsub("Acc", "Accelerometer", names(tidy))
names(tidy)<-gsub("Gyro", "Gyroscope", names(tidy))
names(tidy)<-gsub("BodyBody", "Body", names(tidy))
names(tidy)<-gsub("Mag", "Magnitude", names(tidy))
names(tidy)<-gsub("^t", "Time", names(tidy))
names(tidy)<-gsub("^f", "Frequency", names(tidy))
names(tidy)<-gsub("tBody", "TimeBody", names(tidy))
names(tidy)<-gsub("-mean()", "Mean", names(tidy), ignore.case = TRUE)
names(tidy)<-gsub("-std()", "STD", names(tidy), ignore.case = TRUE)
names(tidy)<-gsub("-freq()", "Frequency", names(tidy), ignore.case = TRUE)
names(tidy)<-gsub("angle", "Angle", names(tidy))
names(tidy)<-gsub("gravity", "Gravity", names(tidy))

#Create final tidy data set with average of each variable.

final <- tidy %>%
  group_by(sub, activity) %>%
  summarise_all(funs(mean))
write.table(final, "Final.txt", row.name=FALSE)
