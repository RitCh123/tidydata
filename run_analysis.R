#Step 1: Merging Test and Train text datasets together
test <- data.table::data.table(numeric(length=561))

test <- rbind(read.table("data/UCI HAR Dataset/test/X_test.txt"), read.table("data/UCI HAR Dataset/train/X_train.txt"))

test <- cbind(test, rbind(read.table("data/UCI HAR Dataset/test/y_test.txt"), read.table("data/UCI HAR Dataset/train/y_train.txt")))

test <- cbind(test, rbind(read.table("data/UCI HAR Dataset/test/subject_test.txt"), read.table("data/UCI HAR Dataset/train/subject_train.txt")))

#for step 5

newStep <- data.table::data.table(test)

#Step 2: Extracting mean and standard deviation from test dataset

meanTest <- sapply(test,mean)

sdTest <- sapply(test, sd)

#Step 3: Converting the Y_test.txt column to their appropriate activity 
activityLabel <- read.table("data/UCI HAR Dataset/activity_labels.txt")

for (label in 1: length(test[[562]])) {
  
  test[[562]][[label]] <- activityLabel[[2]][test[[562]][[label]]]
  
}

#Step 4: Labeling columns appropriately

for (col in 1:length(colnames(test[1:561]))) {
  
  names(test)[col] <- paste("Time and Frequency Vector #", col, sep = "")
}
names(test)[562:563] <- c("Activity by Subject", "Subject Who Participated")

#Step 5: Creating a new dataset with averages of each column
tidySet <- data.table::data.table()

for (col in 1: ncol(test)) {
  test[[col]] <- as.numeric(as.character(test[[col]]))
  tidySet <- cbind(tidySet, mean(test[[col]]))
}
names(tidySet) <- names(test)



