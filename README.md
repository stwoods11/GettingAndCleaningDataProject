# Function Overview

The run_analysis function returns a tidy data set that organizes the aggregate means of the mean and standard deviation values of the Human Activity Recognition Using Smartphones Data Set by Subject and Activity.  This function also write text and CSV output files named tidy_data.txt and tidy_data.csv respectively.

Data was collected on 30 subjects performing 6 different activities.  Therefore, the tidy data set has 180 rows.  The aggregate means in the data set cover 66 different mean and standard deviation measurements.  Together with the subject and activity dimensional columns, the tidy data set has 68 columns.

# Method To Create Tidy Data Set

The following step detail the procedure used to create the tidy data set (i.e. what the run_analysis() function does).

* Download and unpackage raw source files
* Read and merge the raw data
* Set the column names
* Subset the data
* Recategorize the activity column data
* Rename the columns
* Aggregate the data
* Write output files

## Download and unpackage raw source files

Files were downloaded from the UCI web site and unzipped using the download.file and unzip functions.  The put the data in my file system for further processing.

## Read and merge the raw data

Each of the 6 raw data files (3 training and 3 test) were read into tables using read.table.  Then the tables were merged using rbind and cbind.

## Set the column names

To set the column names the feature.txt file containing the column names was read and assigned as the column names using the names function.

## Subset the data

Subsetting the data was a bit tricky because I first had to identify those columns containing mean and standard deviation measurement.  I did this by looking for "-mean()" and "-std()" text patterns in the column names using grep.  With a logical vector that identified the columns needed, it was simple to subset the table.  I also made sure to keep the Subject and Activity columns.

## Recategorize the activity column data

To replace the numerical values in the Activity column with descriptive categorization terms, I read in the activity_labels.txt file which contained the activity labels.  Compariing the numerical index in this file with the Activity data, it was straight forward to replace the numbers with readable terms.  Care was needed to convert the Activity name from a factor to a character upon assignment.

## Rename the columns

Renaming/standardizing the column names is an area of subjective preference.  I like humpbacked, short names.  So, I did not grow the column names by say changing StdDev to StandardDeviation.  I think anyone using this data understands its context and know that StdDev means standard deviation.  Similarly, I left other abbreviated terms alone, like Gyro, Mag, et cetera.  To standardize the names so that they all conform and look the same, I used the sub (substitute) function to perform the following ...

  * Replace "-mean()" with "Mean"
  * Replace "-std()" with "StdDev"
  * Replace "-" with ""
  * Replace "fB" with "FreqB"
  * Replace "fG" with "FreqG"
  * Replace "tB" with "TimeB"
  * Replace "tG" with "TimeG"
  * Replace "BodyBody" with "Body"

## Aggregate the data

Aggregating the data was easy, given the right function!  I used the aggregate function to aggregate the data by Subject and Activity, performing mean as the aggregating function.  So, all of the data for each Subject/Activity combination was collapsed to one row and the measurements were meaned.

## Write output files

The last step was to write the tidy data set (180 rows, 68 columns) to a text file and a CSV file.

# Code Book

The data has 2 dimensional columns ... Subject and Activity.

* Subject - The subject that the measurements were performed on.
* Activity - The activity that the subject was performing when the measurements were taken.

The remaining columns are various measurements that were taken.  Rather than describing each column individually, the description of the measurement can be determined by parsing the column name.  The following is the general structure of the column names.

[Domain] [Acceleration signal] [Measurement device] [Jerk] [Mag] [Measurement] [Dimension]

The following describes each piece of the column name and what it says about the measurement.

* Domain - "Time" for time domain or "Freq" for frequency domain (i.e. a Fast Fourier Transform was applied to the signal measurement.
* Acceleration signal - "Body" for body acceleration signals or "Gravity" for gravity acceleration signals.
* Measurement device - "Acc" for accelerometer or "Gyro" for gyroscope.
* Jerk - If applicable, "Jerk" indicates if the body linear acceleration and angular velocity were derived in time.
* Mag - If applicable, "Mag" indicates if the magnitude of the three-dimensional signals was calculated using the Euclidean norm.
* Measurement - "Mean" for average or "StdDev" for standard deviation.
* Dimension - If applicable, the dimensional axis of the measurement ... "X", "Y", or "Z".

Finally, for each Subject and Activity, several measurements were taken.  For each, the data set shows the MEAN of the measurements taken across all of the trials.  Therefore, each Subject/Activity combination is represented by one row in the data set and the measurements in that row are the means of the measurements taken across all of the trials for the Subject performing that Activity.

## Updated Original Code Book

The following is an update to the original code book documented in the features_info.txt file.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals TimeAcc-XYZ and TimeGyro-XYZ. These time domain signals (prefix 'Time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TimeBodyAcc-XYZ and TimeGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TimeBodyAccJerk-XYZ and TimeBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TimeBodyAccMag, TimeGravityAccMag, TimeBodyAccJerkMag, TimeBodyGyroMag, TimeBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FreqBodyAcc-XYZ, FreqBodyAccJerk-XYZ, FreqBodyGyro-XYZ, FreqBodyAccJerkMag, FreqBodyGyroMag, FreqBodyGyroJerkMag. (Note the 'Freq' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* TimeBodyAcc-XYZ
* TimeGravityAcc-XYZ
* TimeBodyAccJerk-XYZ
* TimeBodyGyro-XYZ
* TimeBodyGyroJerk-XYZ
* TimeBodyAccMag
* TimeGravityAccMag
* TimeBodyAccJerkMag
* TimeBodyGyroMag
* TimeBodyGyroJerkMag
* FreqBodyAcc-XYZ
* FreqBodyAccJerk-XYZ
* FreqBodyGyro-XYZ
* FreqBodyAccMag
* FreqBodyAccJerkMag
* FreqBodyGyroMag
* FreqBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* Mean: Mean value
* StdDev: Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* GravityMean
* TimeBodyAccMean
* TimeBodyAccJerkMean
* TimeBodyGyroMean
* TimeBodyGyroJerkMean

## Full Column List

The following is a full list of the columns in the tidy data set.

1. Subject
2. Activity
3. TimeBodyAccMeanX
4. TimeBodyAccMeanY
5. TimeBodyAccMeanZ
6. TimeBodyAccStdDevX
7. TimeBodyAccStdDevY
8. TimeBodyAccStdDevZ
9. TimeGravityAccMeanX
10. TimeGravityAccMeanY
11. TimeGravityAccMeanZ
12. TimeGravityAccStdDevX
13. TimeGravityAccStdDevY
14. TimeGravityAccStdDevZ
15. TimeBodyAccJerkMeanX
16. TimeBodyAccJerkMeanY
17. TimeBodyAccJerkMeanZ
18. TimeBodyAccJerkStdDevX
19. TimeBodyAccJerkStdDevY
20. TimeBodyAccJerkStdDevZ
21. TimeBodyGyroMeanX
22. TimeBodyGyroMeanY
23. TimeBodyGyroMeanZ
24. TimeBodyGyroStdDevX
25. TimeBodyGyroStdDevY
26. TimeBodyGyroStdDevZ
27. TimeBodyGyroJerkMeanX
28. TimeBodyGyroJerkMeanY
29. TimeBodyGyroJerkMeanZ
30. TimeBodyGyroJerkStdDevX
31. TimeBodyGyroJerkStdDevY
32. TimeBodyGyroJerkStdDevZ
33. TimeBodyAccMagMean
34. TimeBodyAccMagStdDev
35. TimeGravityAccMagMean
36. TimeGravityAccMagStdDev
37. TimeBodyAccJerkMagMean
38. TimeBodyAccJerkMagStdDev
39. TimeBodyGyroMagMean
40. TimeBodyGyroMagStdDev
41. TimeBodyGyroJerkMagMean
42. TimeBodyGyroJerkMagStdDev
43. FreqBodyAccMeanX
44. FreqBodyAccMeanY
45. FreqBodyAccMeanZ
46. FreqBodyAccStdDevX
47. FreqBodyAccStdDevY
48. FreqBodyAccStdDevZ
49. FreqBodyAccJerkMeanX
50. FreqBodyAccJerkMeanY
51. FreqBodyAccJerkMeanZ
52. FreqBodyAccJerkStdDevX
53. FreqBodyAccJerkStdDevY
54. FreqBodyAccJerkStdDevZ
55. FreqBodyGyroMeanX
56. FreqBodyGyroMeanY
57. FreqBodyGyroMeanZ
58. FreqBodyGyroStdDevX
59. FreqBodyGyroStdDevY
60. FreqBodyGyroStdDevZ
61. FreqBodyAccMagMean
62. FreqBodyAccMagStdDev
63. FreqBodyAccJerkMagMean
64. FreqBodyAccJerkMagStdDev
65. FreqBodyGyroMagMean
66. FreqBodyGyroMagStdDev
67. FreqBodyGyroJerkMagMean
68. FreqBodyGyroJerkMagStdDev