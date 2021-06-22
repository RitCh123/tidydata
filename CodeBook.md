# Code Book
#### This is my code book to explain the different variables and steps that I used to obtain my clean and tidy data from the test and train datasets

## Variables
### Test
#### The test variable directly stores the information read from the test and train datasets. When reading the test and train text files, I ignored the  Inertial Signals folder and read only the subject, X, and y text files as per the guidelines in the README.txt file. I first added the row of X_test and X_train.txt merged together. Then I added a column detailing the activity by merging y_test.txt and y_train.txt together. I repeated this same process for the files subject_train.txt and subject_test.txt.

### New Step
#### newStep (camelCase) is the variable that I used for step #5 for the project. I reshaped the test variable by changing the names of the activities (by numbers) to character vectors (e.g "WALKING"). However, I had to take the average of the activities. In doing so, I needed the activities columns to be a numeric vector, not a character vector. Thus, I copied (in memory) the data set to preserve the activities column as a numeric vector.

### Mean Test
#### The meanTest (camelCase) variable was used to store the averages of all the observations in the data.table type. By using sapply() and looping through the entire dataframe, I can easily (and quickly) take the averages of all columns (observations).
### sd Test
#### The sdTest variable was used to store the standard deviations of the all the observations in the data.table type. By using the same method of meanTest, I recorded all the standard deviation measurements of the test variable.

### Index
#### The index variable is used to simplify the code when indexing and making sure that the code is more readable. The index variable stores the number (1-6), denoting the activity name based on factor level. Using the index variable, I can retrieve the appropriate activity by number.

### Activity Label
#### Activity Label reads the activity_label.txt file and converts to a data.table object. The table consists of two columns. The first column details the numbers for which the activity is associated with. The second column details the activity name (e.g "WALKING", "SITTING", etc.)

### Tidy Set
####Tidy set is a variable that contains the tidy, independent set with the averages of all vectors (columns 1 to 561) as per different activity number and subject label (from 1 to 30). The subjects and activity numbers are in the columns while the vector averages are documented in the rows.

### Mean Sol
#### Mean sol is the variable that contains the averages of all vectors. I used rbind() to add all the averages to the dataset. The meanSol variable resets after every iteration of the loop. I used the loop of all the unique values of subject labels and activity numbers. 

## Data
### X_test.txt and X_train.txt
#### Both the test data has 561 columns, while the train data has 1 column. The units are in frequencies measurements, as the labels for both the test and train data are time and frequency vectors, as per the README.txt file. I used the library data.table to read the data from the text file. In order to read such a large file (25 MB) efficiently without occupying too much memory, I felt it was a feasible option to use data.table. The test and train data have 10299 columns. 
### y_test.txt and y_train.txt
#### The y_test.txt and y_train.txt files both have one column, detailing a series of numbers that describe the activity names. Another text file provided, activity_labels.txt, would be used further to convert the numbers into factor variables, which then could processed as proper and tidy data.
### subject_test.txt and subject_train.txt
#### subject_test.txt and subject_train.txt both have subject labels that detail the subject who performed the experiment. The labels consist from a range of 1 to 30, which indicated 30 participants in the study. The subject_test.txt and subject_train.txt have one column each. Merging both resulted in a one column as well. In all, the total number of columns is 561 columns (for X_test.txt and X_train.txt) + 1 column (y_test.txt and y_train.txt) + 1 column (subject_test.txt and subject_train.txt) = 563 total columns.

## Transformations
### Merging 
#### I had to perform the merging operations manually, with each merging operations taking place each line. I used the functions rbind() and cbind() to manually insert rows and columns from an empty data.table and insert data read from the test and train files. The code would look like this:

``` R
test <- data.table::data.table(numeric(length=561))

test <- rbind(read.table("data/UCI HAR Dataset/test/X_test.txt"), read.table("data/UCI HAR Dataset/train/X_train.txt"))

test <- cbind(test, rbind(read.table("data/UCI HAR Dataset/test/y_test.txt"), read.table("data/UCI HAR Dataset/train/y_train.txt")))

test <- cbind(test, rbind(read.table("data/UCI HAR Dataset/test/subject_test.txt"), read.table("data/UCI HAR Dataset/train/subject_train.txt")))


```

#### While individually reading the table and manually adding rows was repetitive, the outcome was the same and all the files from the test and train data sets were merged.


### Renaming Columns
#### Renaming columns was an important part in tidying up the data set and finally downloading it as a text file. The column names had to be appropriate. I set up the following code block to rename the columsn efficiently and the most appropriate manner possible: 

``` R
names(test)[col] <- paste("Time and Frequency Vector #", col, sep = "")
```

#### Doing this ensured that all the vector columns had the consistent name Time and Frequency Vector #___, which suited the column as I provided a brief description of the measurements and the units that the measurements were in. Renaming the Tidy Data variable required getting the name of the dataset and slicing it into two groups, one describing the subject label and the other activity name. Then I could easily rename them in the following manner: 

 - Subject # ____ 
 - Activity # ____

## Additional Information
#### In the submitted GitHub repo, you will find the following:
 1. A run_analysis.R file that has the code that I used for processing the raw_text files into usable "analyizable" data
 2. A text file that contains the tidy data set that I created at the end of this project.
 
#### The following code snippets will be found in the README.md file of this GitHub repo. The link of the GitHub repo can be found [here](https://github.com/RitCh123/tidydata).
