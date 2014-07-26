# This function performs the following steps to satisfy the course project for Getting and Cleaning Data.

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set.
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

run_analysis <- function () {
    
    # Download and unzip the data into the working directory.  This can be commented out after run once for efficiency.
    message("Downloading and unpackaging data ...")
    #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata_projectfiles_UCI HAR Dataset.zip")
    #unzip("getdata_projectfiles_UCI HAR Dataset.zip")

    # Read the training and test data from files into tables.
    message("Reading and merging data ...")
    s_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
    x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
    s_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
    x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
    
    # Merge the columns together.
    train_data <- cbind(s_train, y_train, x_train)
    test_data <- cbind(s_test, y_test, x_test)

    # Merge the training and test data together.
    all_data <- rbind(train_data, test_data)
    
    # Set column names on the data.
    features <- read.table("UCI HAR Dataset/features.txt")
    feature_names <- c("Subject", "Activity", as.character(features[,2]))
    names(all_data) <- feature_names
    
    # Subset the date to extract just the means and standard deviations.  Maintain the original column order.
    message("Subsetting data ...")
    
    # Get indexes of columns that have "-mean()", "-std()", "Subject", or "Activity" in the name.
    cols_mean <- grep("-mean()", names(all_data), fixed=TRUE)
    cols_std <- grep("-std()", names(all_data), fixed=TRUE)
    cols_other <- grep("Subject|Activity", names(all_data))
    # Put the column indexes into one vector and order it.
    cols <- c(cols_mean, cols_std, cols_other)
    cols <- cols[order(cols)]
    
    # Subset the entire data set by the selected columns.
    tidy_data <- all_data[,cols]  
    
    # Replace the data in the Activity columns with textual, rather than the numeric, categorizations.
    message("Recategorizing activity with label names ...")
    activity_names <- read.table("UCI HAR Dataset/activity_labels.txt")
    names(activity_names) <- c("Index", "Activity")
    tidy_data$Activity <- as.character(activity_names[tidy_data$Activity, "Activity"])
    
    # Rename the columns to make them more readable using character substitutions.
    message("Renaming columns ...")
    names <- names(tidy_data)
    names <- sub("-mean\\(\\)", "Mean", names)
    names <- sub("-std\\(\\)", "StdDev", names)
    names <- sub("-", "", names)
    names <- sub("fB", "FreqB", names)
    names <- sub("fG", "FreqG", names)
    names <- sub("tB", "TimeB", names)
    names <- sub("tG", "TimeG", names)
    names <- sub("BodyBody", "Body", names)
    names(tidy_data) <- names
    
    # Aggregate the data by subject and activity, if the function parameter says to do so.
    message("Aggegating data ...")
    tidy_data <- aggregate(tidy_data[3:length(tidy_data)], list(Subject = tidy_data$Subject, Activity = tidy_data$Activity), mean)
    
    # Write output files in text and csv formats.
    write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
    write.table(tidy_data, "tidy_data.csv", row.names = FALSE, sep = ",")

    tidy_data
}