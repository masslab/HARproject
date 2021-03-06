# Code Book for UCI HAR Data Cleanup
Version 1.0

November 20, 2014

written by S. Mass for JHSPH DSS Coursera 'Getting & Cleaning Data' course

## Overview
This project required the creation of a script to perform general clean-up of the UCI HAR dataset, recombining several individual datasets contained therein, reduction of the scope and reorganization of the resulting dataset and then reporting aggregate data. The `run_analysis.R` script cleans-up and renames the variables in the data set (see below for details). It then subsets only the mean and standard deviation data. The output is a reduced dimension aggregate data set that contains means for each activity by each subject.

### Original Study Design
This is very liberally paraphrased from the original data set readme file. 

The original study used 30 test subjects performing 6 activities while wearing a Samsung Galaxy SII smartphone with an accelerometer and gyroscope.  Data were recorded during the activities to capture triaxial linear acceleration and triaxial angular velocity.

For each subject the following data were collected:

- Total triaxial acceleration (from accelerometer) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- 561 variables with time and frequency. 
- Activity being performed. 
- Subject identifier.

For more details, see the README.txt file included in the original UCI HAR data set.

## Original Data Set
The original data in the UCI HAR Data set contains the following files:

- 'README.txt'

- 'features_info.txt': information about the variables used on the feature vector.

- 'features.txt': list of all features (561 variable names).

- 'activity_labels.txt': a name-value key with 6 activities and their codes.

- 'train/X_train.txt': training set (feature data for the 561 variables).

- 'train/y_train.txt': training labels (activity codes).

- 'test/X_test.txt': test set (feature data for the 561 variables).

- 'test/y_test.txt': test labels (activity codes).

- 'test/subject_train.txt': rows identify the subject who performed the activity 

- 'train/subject_train.txt': rows identify the subject who performed the activity 

- 'test/Inertial Signals/: **nothing in this subdirectory is used**

- 'train/Inertial Signals/: **nothing in this subdirectory is used**

####Variable Units
Unit data for measured and calculated variables were not given in the original data set documents.  We are *assuming* that velocity is in m/s, acceleration is in m/s^2 and frequency is in hz (cycles/s).  However, no further mention of units will be made here or in the variable maps.

## Transformations & Processing
The following operations are performed:

##### Original Variable Names are Transformed
The variable names in the test and train data sets were changed according to the following rules:

1. Reserved words and illegal characters were removed (replaced with periods and elipses)

2. Leading 't' prefixes  were changed to 'Total'

3. Leading 'f' prefixes were changed to 'FFT' (for fast Fourier transform)

4. Trailing lowercase 'mean' was changed to 'Mean' for increased readability

5. Trailing lowercase 'std' was changed to 'STD' for increased readability

6. A pervasive typographical error (BodyBody) was fixed by removing the duplication

7. The resulting variable names were *cleaned* to remove internal periods and trailing elipses (artifacts of step 1)

8. Trailing 'X', 'Y', and 'Z' were maintained as terminal uppercase letters even though they sometimes decreased readability in order to preserve the cartesian coordinate pertaining to the variable.

###### Variable name key
The script creates a key called `nameKey.txt` which is part of the output (see Output below).  This key lists all 86 variables (columns) from the original data set that are included in the tidyData output.  The first column contains the original variable column number [1:561]. The second column contains the original name and the third column contains the transformed name. This is for convenience only and will permit the researcher/analyst to clearly see which variables in the resulting output files correspond to which variables in the original data set.

**Note** The column headers in the final output (see the Variable Map Table below) are not identical to the names in `nameKey` in one respect only: 

- the Activity and Subject columns are not represented in the nameKey file

See the Variable Map table below for a complete description of the variables in the `tidyData.txt` output file.

##### Test and Train Data are Merged into a Single Data Set
The *test* data consists of 2,947 observations of 561 variables.  The *train* data consists of 7,352 observations of the same 561 variables.  These are merged (*train* was appended to *test*). The merged data is 10,299 observations.

##### The Subject and Activity Data are Appended to the Merged Data
The subject and activity data were originally maintained as separate files from the recorded measurements.  These are added as additional variables (columns).

##### Activity Codes are Replaced with Activity Names
The original data set used numeric codes for activities.  The codes are replaced by the actual activity names.

##### Variables that *are not* Means or Standard Deviations are Excluded
86 of the 561 variables in the original data set were summary data (either means or standard deviations) of other variables.  These summary variables are maintained and the remaining 475 variables are excluded.

##### The Resulting Data are Grouped by Subject and Activity and then Averaged
The merged, appended and cleaned data are then analyzed by calculating the mean for each variable after grouping by Activity and Subject.  The result is a data set of 180 observations (30 subjects by 6 activities) of 88 variables (the 86 original summary variables plus Activity and Subject).

## Output
The following output is generated by `run_analysis.R`:

1. a new directory named `tidyFiles` is created in the working directory

2. a text file named `tidyData.txt` is written to the `tidyFiles` directory

3. a text file named `nameKey.txt` is written to the `tidyFiles` directory

#### tidyData.txt
This text file is the main output of the script and contains 180 observations of 88 variables.  It is a wide format tidy data set that aggregates the means of each of the 86 variables identified in the instructions (variables with means and standard deviations) sorted by activity and subject, which are columns 1 and 2 respectively.

##### Map of Variables
The following table maps all of the variables in the `tidyData.txt` file to their original names in the HAR data set.  The first column (Col#) refers to the `tidyData` data set.  The second column (Var#) refers to the original data set.  These refer to row numbers in the `features.txt` file which correspond to column numbers in the test and train data files. If the variable was not included in the original set, it is represented as NA.  The third column (Original Name) is the name of the variable in the original HAR data set.  The fourth column (New Name) is the name that resulted from the transformations done by `run_analysis.R`.  The fifth column (Value) is the type of data (*[chr]* for character; *[int]* for integer; *[num]* for double (real numbers)) and the range of values contained in the variable.

| Col# |Var#  |  Original Name   |  New Name        | Values   |
|:----|:----|:------------|:----------- |:---------|
|1 |NA | NA | Activity |[chr] 6|
|2|NA | NA | Subject | [int] 30|
|3|1 |tBodyAcc-mean()-X |TotalBodyAccMeanX|  [num]1 |
|4|2 |tBodyAcc-mean()-Y |TotalBodyAccMeanY|  [num]1 | 
|5|3 |tBodyAcc-mean()-Z |TotalBodyAccMeanZ|  [num]1 |
|6|4 |tBodyAcc-std()-X |TotalBodyAccSTDX|   [num]1 |
|7|5 |tBodyAcc-std()-Y |TotalBodyAccSTDY|   [num]1 |
|8|6 |tBodyAcc-std()-Z |TotalBodyAccSTDZ|   [num]1 |
|9|41 |tGravityAcc-mean()-X |TotalGravityAccMeanX|   [num]1 |
|10|42 |tGravityAcc-mean()-Y |TotalGravityAccMeanY|   [num]1 |
|11|43 |tGravityAcc-mean()-Z |TotalGravityAccMeanZ|   [num]1 |
|12|44 |tGravityAcc-std()-X |TotalGravityAccSTDX|   [num]1 |
|13|45 |tGravityAcc-std()-Y |TotalGravityAccSTDY|   [num]1 |
|14|46 |tGravityAcc-std()-Z |TotalGravityAccSTDZ|   [num]1 |
|15|81 |tBodyAccJerk-mean()-X |TotalBodyAccJerkMeanX|   [num]1 |
|16|82 |tBodyAccJerk-mean()-Y |TotalBodyAccJerkMeanY|   [num]1 |
|17|83 |tBodyAccJerk-mean()-Z |TotalBodyAccJerkMeanZ|   [num]1 |
|18|84 |tBodyAccJerk-std()-X |TotalBodyAccJerkSTDX|   [num]1 |
|19|85 |tBodyAccJerk-std()-Y |TotalBodyAccJerkSTDY|   [num]1 |
|20|86 |tBodyAccJerk-std()-Z |TotalBodyAccJerkSTDZ|  [num]1 |
|21|121 |tBodyGyro-mean()-X |TotalBodyGyroMeanX|   [num]1 |
|22|122 |tBodyGyro-mean()-Y |TotalBodyGyroMeanY|   [num]1 |
|23|123 |tBodyGyro-mean()-Z |TotalBodyGyroMeanZ|   [num]1 |
|24|124 |tBodyGyro-std()-X |TotalBodyGyroSTDX|   [num]1 |
|25|125 |tBodyGyro-std()-Y |TotalBodyGyroSTDY|   [num]1 |
|26|126 |tBodyGyro-std()-Z |TotalBodyGyroSTDZ|   [num]1 |
|27|161 |tBodyGyroJerk-mean()-X |TotalBodyGyroJerkMeanX|   [num]1 |
|28|162 |tBodyGyroJerk-mean()-Y |TotalBodyGyroJerkMeanY|   [num]1 |
|29|163 |tBodyGyroJerk-mean()-Z |TotalBodyGyroJerkMeanZ|   [num]1 |
|30|164 |tBodyGyroJerk-std()-X |TotalBodyGyroJerkSTDX|   [num]1 |
|31|165 |tBodyGyroJerk-std()-Y |TotalBodyGyroJerkSTDY|   [num]1 |
|32|166 |tBodyGyroJerk-std()-Z |TotalBodyGyroJerkSTDZ|   [num]1 |
|33|201 |tBodyAccMag-mean() |TotalBodyAccMagMean|   [num]1 |
|34|202 |tBodyAccMag-std() |TotalBodyAccMagSTD|   [num]1 |
|35|214 |tGravityAccMag-mean() |TotalGravityAccMagMean|   [num]1 |
|36|215 |tGravityAccMag-std() |TotalGravityAccMagSTD|   [num]1 |
|37|227 |tBodyAccJerkMag-mean() |TotalBodyAccJerkMagMean|   [num]1 |
|38|228 |tBodyAccJerkMag-std() |TotalBodyAccJerkMagSTD|[num]1|
|39|240 |tBodyGyroMag-mean() |TotalBodyGyroMagMean|  [num]1 |
|40|241 |tBodyGyroMag-std() |TotalBodyGyroMagSTD|  [num]1 |
|41|253 |tBodyGyroJerkMag-mean() |TotalBodyGyroJerkMagMean|  [num]1 |
|42|254 |tBodyGyroJerkMag-std() |TotalBodyGyroJerkMagSTD|  [num]1 |
|43|266 |fBodyAcc-mean()-X |FFTBodyAccMeanX|  [num]1 |
|44|267 |fBodyAcc-mean()-Y |FFTBodyAccMeanY|  [num]1 |
|45|268 |fBodyAcc-mean()-Z |FFTBodyAccMeanZ|  [num]1 |
|46|269 |fBodyAcc-std()-X |FFTBodyAccSTDX|  [num]1 |
|47|270 |fBodyAcc-std()-Y |FFTBodyAccSTDY|  [num]1 |
|48|271 |fBodyAcc-std()-Z |FFTBodyAccSTDZ|  [num]1 |
|49|294 |fBodyAcc-meanFreq()-X |FFTBodyAccMeanFreqX|  [num]1 |
|50|295 |fBodyAcc-meanFreq()-Y |FFTBodyAccMeanFreqY|  [num]1 |
|51|296 |fBodyAcc-meanFreq()-Z |FFTBodyAccMeanFreqZ|  [num]1 |
|52|345 |fBodyAccJerk-mean()-X |FFTBodyAccJerkMeanX|  [num]1 |
|53|346 |fBodyAccJerk-mean()-Y |FFTBodyAccJerkMeanY|  [num]1 |
|54|347 |fBodyAccJerk-mean()-Z |FFTBodyAccJerkMeanZ|  [num]1 |
|55|348 |fBodyAccJerk-std()-X |FFTBodyAccJerkSTDX|  [num]1 |
|56|349 |fBodyAccJerk-std()-Y |FFTBodyAccJerkSTDY|  [num]1 |
|57|350 |fBodyAccJerk-std()-Z |FFTBodyAccJerkSTDZ|  [num]1 |
|58|373 |fBodyAccJerk-meanFreq()-X |FFTBodyAccJerkMeanFreqX|  [num]1 |
|59|374 |fBodyAccJerk-meanFreq()-Y |FFTBodyAccJerkMeanFreqY|  [num]1 |
|60|375 |fBodyAccJerk-meanFreq()-Z |FFTBodyAccJerkMeanFreqZ|  [num]1 |
|61|424 |fBodyGyro-mean()-X |FFTBodyGyroMeanX|  [num]1 |
|62|425 |fBodyGyro-mean()-Y |FFTBodyGyroMeanY|  [num]1 |
|63|426 |fBodyGyro-mean()-Z |FFTBodyGyroMeanZ|  [num]1 |
|64|427 |fBodyGyro-std()-X |FFTBodyGyroSTDX|  [num]1 |
|65|428 |fBodyGyro-std()-Y |FFTBodyGyroSTDY|  [num]1 |
|66|429 |fBodyGyro-std()-Z |FFTBodyGyroSTDZ|  [num]1 |
|67|452 |fBodyGyro-meanFreq()-X |FFTBodyGyroMeanFreqX|  [num]1 |
|68|453 |fBodyGyro-meanFreq()-Y |FFTBodyGyroMeanFreqY|  [num]1 |
|69|454 |fBodyGyro-meanFreq()-Z |FFTBodyGyroMeanFreqZ|  [num]1 |
|70|503 |fBodyAccMag-mean() |FFTBodyAccMagMean|  [num]1 |
|71|504 |fBodyAccMag-std() |FFTBodyAccMagSTD|  [num]1 |
|72|513 |fBodyAccMag-meanFreq() |FFTBodyAccMagMeanFreq|  [num]1 |
|73|516 |fBodyBodyAccJerkMag-mean() |FFTBodyAccJerkMagMean|[num]1 |
|74|517 |fBodyBodyAccJerkMag-std() |FFTBodyAccJerkMagSTD|[num]1 |
|75|526 |fBodyBodyAccJerkMag-meanFreq() |FFTBodyAccJerkMagMeanFreq|[num]1 |
|76|529 |fBodyBodyGyroMag-mean() |FFTBodyGyroMagMean|[num]1 |
|77|530 |fBodyBodyGyroMag-std() |FFTBodyGyroMagSTD|[num]1 |
|78|539 |fBodyBodyGyroMag-meanFreq() |FFTBodyGyroMagMeanFreq|[num]1 |
|79|542 |fBodyBodyGyroJerkMag-mean() |FFTBodyGyroJerkMagMean|[num]1 |
|80|543 |fBodyBodyGyroJerkMag-std() |FFTBodyGyroJerkMagSTD|[num]1 |
|81|552 |fBodyBodyGyroJerkMag-meanFreq() |FFTBodyGyroJerkMagMeanFreq|[num]1 |
|82|555 |angle(tBodyAccMean,gravity) |angletBodyAccMeangravity|[num]1 |
|83|556 |angle(tBodyAccJerkMean),gravityMean) |angletBodyAccJerkMeangravityMean|[num]1 |
|84|557 |angle(tBodyGyroMean,gravityMean) |angletBodyGyroMeangravityMean|[num]1 |
|85|558 |angle(tBodyGyroJerkMean,gravityMean) |angletBodyGyroJerkMeangravityMean|[num]1 |
|86|559 |angle(X,gravityMean) |angleXgravityMean|[num]1 |
|87|560 |angle(Y,gravityMean) |angleYgravityMean|[num]1 |
|88|561 |angle(Z,gravityMean) |angleZgravityMean|[num]1 |
**Note** See *Variable Units* in the *Original Data Set* section above concerning units for variables.

#### nameKey.txt
This text file was described above in detail and is provided for convenience to enable machine-based cross-referencing of the new transformed variable names in the tidy data with the original variable names. It is essentially the same data represented in the table above without the first column (row numbers corresponding to column numbers in `tidyData.txt`), and without the fifth column (Values).

***
###### Acknowledgements
- several worthwhile posts on the Coursera Discussion forum for the course project, especially David Hood's Project FAQ