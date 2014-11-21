# Code Book for UCI HAR Data Cleanup
Version 1.0

November 20, 2014

written by S. Mass for JHSPH DSS Coursera 'Getting & Cleaning Data' course

## Overview
This project required the creation of a script to perform general clean-up of the UCI HAR dataset, recombining several individual datasets contained therein, reduction of the scope and reorganization of the resulting dataset and then reporting aggregate data. The principle processing cleans-up and renames the variables in the data set (see below for details) and then subsets only the mean and standard deviation data to produce a reduced dimension aggregate data frame that contains means for each activity by each subject.

### Original Study Design
The original study used 30 test subjects performing 6 activities while wearing a Samsung Galaxy SII smartphone with an accelerometer and gyroscope.  Data were recorded during the activities to capture 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

For each subject the following data were collected:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

For more details, see the README.txt file included in the original UCI HAR data set.

## Original Data Set
The original data in the UCI HAR Data set contains the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'test/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/Inertial Signals/: **nothing in this subdirectory is used**

- 'train/Inertial Signals/: **nothing in this subdirectory is used**


## Transformations & Processing
The following operations are performed:

#### Original Variable Names are Transformed
The variable names in the test and train data sets were changed according to the following rules:

1. `make.names()` was applied to remove reserved words and illegal characters

2. Leading 't' prefixes  were changed to 'Total'

3. Leading 'f' prefixes were changed to 'FFT' (for fast Fourier transform)

4. Trailing lowercase 'mean' was changed to 'Mean' for increased readability

5. Trailing lowercase 'std' was changed to 'STD' for increased readability

6. A pervasive typographical error (BodyBody) was fixed by removing the duplication

7. The resulting variable names were *cleaned* to remove internal periods and trailing elipses (some of these were artifacts of the `make.names()` operation)

8. Trailing 'X', 'Y', and 'Z' were maintained as terminal uppercase letters even though they sometimes decreased readability in order to preserve the cartesian coordinate pertaining to the variable.

##### Variable name key
The script creates a key called `nameKey.txt` which is part of the output (see Output below).  This key lists all 86 variables (columns) that are in the final data set as rows.  The first column indicates the original variable column number [1:561] while the second column contains the original name and the third column contains the transformed name. This is for convenience only and will permit the researcher/analyst to clearly understand which variables in the resulting output files correspond to which variables in the original data set.

**Note** The column headers in the final output (see the Variable Map Table below) are not identical to the names in `nameKey` in two respects: 

1. the variable name is prepended by 'mean' and enclosed in parentheses to indicate that these are averages of that variable

2. the Activity and Subject columns are not represented

#### Test and Train Data are Merged into a Single Data Set
The *test* data consists of 2,947 observations of 561 variables.  The *train* data consists of 7,352 observations of the same 561 variables.  These are merged (*train* was appended to *test*).

#### The Subject and Activity Data are Appended to the Merged Data
The subject and activity data were originally maintained as separate files from the recorded measurements.  These are added as additional variables (columns).

#### Activity Codes are Replaced with Activity Names
The original data set used numeric codes for activities.  The codes are replaced by the actual activity names.

#### Variables that *are not* Means or Standard Deviations are Excluded
86 of the 561 variables in the original data set were summary data (either means or standard deviations) of other variables.  These summary variables are maintained and the remaining 475 variables are excluded.

#### The Resulting Data are Grouped by Subject and Activity and then Averaged
The merged, appended and cleaned data are then analyzed by calculating the mean for each variable after grouping by Activity and Subject.  The result is a data set of 180 observations (30 subjects by 6 activities) of 88 variables (the 86 original summary variables plus Activity and Subject).

## Output
The following output is generated by `run_analysis.R`:

1. a new subdirectory named `tidyFiles` is created in the working directory

2. a text file named `tidyData.txt` is written to the `tidyFiles` directory

3. a text file named `nameKey.txt` is written to the `tidyFiles` directory

#### tidyData.txt
This text file is the main output of the script and contains 180 observations of 88 variables.  It is a wide format tidy data set that aggregates the means of each of the 86 variables identified in the instructions (variables with means and standard deviations) sorted by activity and subject, which are columns 1 and 2 respectively.

##### Map of Variables
The following table maps all of the variables in the `tidyData.txt` file to their original names in the HAR data set.  The first column (Col#) refers to the `tidyData` data set.  The second column (Var#) refers to the original data set.  These refer to row numbers in the `features.txt` file which correspond to column numbers in the test and train data files. If the variable was not included in the original set, it is represented as NA.  The third column (Original Name) is the name of the variable in the original HAR data set.  The fourth column (New Name) is the name that resulted from the transformations done by `run_analysis.R`.  The fifth column (Displayed As) is the manner in which the new variable name is displayed in the header of the `tidyData.txt` file.  The 'name' refers to the New Name. The sixth column (Value) is the type of data and (if applicable) the range of values contained in the variable.

| Col# |Var#  |  Original Name   |  New Name        | Displayed As | Values |
|:----|:----|:------------|:----------- |:------|:------|
|1 |NA | NA | Activity | Activity | 6 [chr]|
|2|NA | NA | Subject | Subject | 30 [int]|
|3|1 |tBodyAcc-mean()-X |TotalBodyAccMeanX| mean(name) | Rational |
|4|2 |tBodyAcc-mean()-Y |TotalBodyAccMeanY| mean(name) | Rational | 
|5|3 |tBodyAcc-mean()-Z |TotalBodyAccMeanZ| mean(name) | Rational |
|6|4 |tBodyAcc-std()-X |TotalBodyAccSTDX| mean(name) |  Rational |
|7|5 |tBodyAcc-std()-Y |TotalBodyAccSTDY| mean(name) |  Rational |
|8|6 |tBodyAcc-std()-Z |TotalBodyAccSTDZ| mean(name) |  Rational |
|9|41 |tGravityAcc-mean()-X |TotalGravityAccMeanX| mean(name) |  Rational |
|10|42 |tGravityAcc-mean()-Y |TotalGravityAccMeanY| mean(name) |  Rational |
|11|43 |tGravityAcc-mean()-Z |TotalGravityAccMeanZ| mean(name) |  Rational |
|12|44 |tGravityAcc-std()-X |TotalGravityAccSTDX| mean(name) |  Rational |
|13|45 |tGravityAcc-std()-Y |TotalGravityAccSTDY| mean(name) |  Rational |
|14|46 |tGravityAcc-std()-Z |TotalGravityAccSTDZ| mean(name) |  Rational |
|15|81 |tBodyAccJerk-mean()-X |TotalBodyAccJerkMeanX| mean(name) |  Rational |
|16|82 |tBodyAccJerk-mean()-Y |TotalBodyAccJerkMeanY| mean(name) |  Rational |
|17|83 |tBodyAccJerk-mean()-Z |TotalBodyAccJerkMeanZ| mean(name) |  Rational |
|18|84 |tBodyAccJerk-std()-X |TotalBodyAccJerkSTDX| mean(name) |  Rational |
|19|85 |tBodyAccJerk-std()-Y |TotalBodyAccJerkSTDY| mean(name) |  Rational |
|20|86 |tBodyAccJerk-std()-Z |TotalBodyAccJerkSTDZ| mean(name) | Rational |
|21|121 |tBodyGyro-mean()-X |TotalBodyGyroMeanX| mean(name) |  Rational |
|22|122 |tBodyGyro-mean()-Y |TotalBodyGyroMeanY| mean(name) |  Rational |
|23|123 |tBodyGyro-mean()-Z |TotalBodyGyroMeanZ| mean(name) |  Rational |
|24|124 |tBodyGyro-std()-X |TotalBodyGyroSTDX| mean(name) |  Rational |
|25|125 |tBodyGyro-std()-Y |TotalBodyGyroSTDY| mean(name) |  Rational |
|26|126 |tBodyGyro-std()-Z |TotalBodyGyroSTDZ| mean(name) |  Rational |
|27|161 |tBodyGyroJerk-mean()-X |TotalBodyGyroJerkMeanX| mean(name) |  Rational |
|28|162 |tBodyGyroJerk-mean()-Y |TotalBodyGyroJerkMeanY| mean(name) |  Rational |
|29|163 |tBodyGyroJerk-mean()-Z |TotalBodyGyroJerkMeanZ| mean(name) |  Rational |
|30|164 |tBodyGyroJerk-std()-X |TotalBodyGyroJerkSTDX| mean(name) |  Rational |
|31|165 |tBodyGyroJerk-std()-Y |TotalBodyGyroJerkSTDY| mean(name) |  Rational |
|32|166 |tBodyGyroJerk-std()-Z |TotalBodyGyroJerkSTDZ| mean(name) |  Rational |
|33|201 |tBodyAccMag-mean() |TotalBodyAccMagMean| mean(name) |  Rational |
|34|202 |tBodyAccMag-std() |TotalBodyAccMagSTD| mean(name) |  Rational |
|35|214 |tGravityAccMag-mean() |TotalGravityAccMagMean| mean(name) |  Rational |
|36|215 |tGravityAccMag-std() |TotalGravityAccMagSTD| mean(name) |  Rational |
|37|227 |tBodyAccJerkMag-mean() |TotalBodyAccJerkMagMean| mean(name) |  Rational |
|38|228 |tBodyAccJerkMag-std() |TotalBodyAccJerkMagSTD| mean(name)|  Rational |
|39|240 |tBodyGyroMag-mean() |TotalBodyGyroMagMean| mean(name) | Rational |
|40|241 |tBodyGyroMag-std() |TotalBodyGyroMagSTD| mean(name) | Rational |
|41|253 |tBodyGyroJerkMag-mean() |TotalBodyGyroJerkMagMean| mean(name) | Rational |
|42|254 |tBodyGyroJerkMag-std() |TotalBodyGyroJerkMagSTD| mean(name) | Rational |
|43|266 |fBodyAcc-mean()-X |FFTBodyAccMeanX| mean(name) | Rational |
|44|267 |fBodyAcc-mean()-Y |FFTBodyAccMeanY| mean(name) | Rational |
|45|268 |fBodyAcc-mean()-Z |FFTBodyAccMeanZ| mean(name) | Rational |
|46|269 |fBodyAcc-std()-X |FFTBodyAccSTDX| mean(name) | Rational |
|47|270 |fBodyAcc-std()-Y |FFTBodyAccSTDY| mean(name) | Rational |
|48|271 |fBodyAcc-std()-Z |FFTBodyAccSTDZ| mean(name) | Rational |
|49|294 |fBodyAcc-meanFreq()-X |FFTBodyAccMeanFreqX| mean(name) | Rational |
|50|295 |fBodyAcc-meanFreq()-Y |FFTBodyAccMeanFreqY| mean(name) | Rational |
|51|296 |fBodyAcc-meanFreq()-Z |FFTBodyAccMeanFreqZ| mean(name) | Rational |
|52|345 |fBodyAccJerk-mean()-X |FFTBodyAccJerkMeanX| mean(name) | Rational |
|53|346 |fBodyAccJerk-mean()-Y |FFTBodyAccJerkMeanY| mean(name) | Rational |
|54|347 |fBodyAccJerk-mean()-Z |FFTBodyAccJerkMeanZ| mean(name) | Rational |
|55|348 |fBodyAccJerk-std()-X |FFTBodyAccJerkSTDX| mean(name) | Rational |
|56|349 |fBodyAccJerk-std()-Y |FFTBodyAccJerkSTDY| mean(name) | Rational |
|57|350 |fBodyAccJerk-std()-Z |FFTBodyAccJerkSTDZ| mean(name) | Rational |
|58|373 |fBodyAccJerk-meanFreq()-X |FFTBodyAccJerkMeanFreqX| mean(name) | Rational |
|59|374 |fBodyAccJerk-meanFreq()-Y |FFTBodyAccJerkMeanFreqY| mean(name) | Rational |
|60|375 |fBodyAccJerk-meanFreq()-Z |FFTBodyAccJerkMeanFreqZ| mean(name) | Rational |
|61|424 |fBodyGyro-mean()-X |FFTBodyGyroMeanX| mean(name) | Rational |
|62|425 |fBodyGyro-mean()-Y |FFTBodyGyroMeanY| mean(name) | Rational |
|63|426 |fBodyGyro-mean()-Z |FFTBodyGyroMeanZ| mean(name) | Rational |
|64|427 |fBodyGyro-std()-X |FFTBodyGyroSTDX| mean(name) | Rational |
|65|428 |fBodyGyro-std()-Y |FFTBodyGyroSTDY| mean(name) | Rational |
|66|429 |fBodyGyro-std()-Z |FFTBodyGyroSTDZ| mean(name) | Rational |
|67|452 |fBodyGyro-meanFreq()-X |FFTBodyGyroMeanFreqX| mean(name) | Rational |
|68|453 |fBodyGyro-meanFreq()-Y |FFTBodyGyroMeanFreqY| mean(name) | Rational |
|69|454 |fBodyGyro-meanFreq()-Z |FFTBodyGyroMeanFreqZ| mean(name) | Rational |
|70|503 |fBodyAccMag-mean() |FFTBodyAccMagMean| mean(name) | Rational |
|71|504 |fBodyAccMag-std() |FFTBodyAccMagSTD| mean(name) | Rational |
|72|513 |fBodyAccMag-meanFreq() |FFTBodyAccMagMeanFreq| mean(name) | Rational |
|73|516 |fAccJerkMag-mean() |FFTBodyAccJerkMagMean| mean(name) | Rational |
|74|517 |fAccJerkMag-std() |FFTBodyAccJerkMagSTD| mean(name) | Rational |
|75|526 |fAccJerkMag-meanFreq() |FFTBodyAccJerkMagMeanFreq| mean(name) | Rational |
|76|529 |fGyroMag-mean() |FFTBodyGyroMagMean| mean(name) | Rational |
|77|530 |fGyroMag-std() |FFTBodyGyroMagSTD| mean(name) | Rational |
|78|539 |fGyroMag-meanFreq() |FFTBodyGyroMagMeanFreq| mean(name) | Rational |
|79|542 |fGyroJerkMag-mean() |FFTBodyGyroJerkMagMean| mean(name) | Rational |
|80|543 |fGyroJerkMag-std() |FFTBodyGyroJerkMagSTD| mean(name) | Rational |
|81|552 |fGyroJerkMag-meanFreq() |FFTBodyGyroJerkMagMeanFreq| mean(name) | Rational |
|82|555 |angle(tBodyAccMean,gravity) |angletBodyAccMeangravity| mean(name) | Rational |
|83|556 |angle(tBodyAccJerkMean),gravityMean) |angletBodyAccJerkMeangravityMean| mean(name) | Rational |
|84|557 |angle(tBodyGyroMean,gravityMean) |angletBodyGyroMeangravityMean| mean(name) | Rational |
|85|558 |angle(tBodyGyroJerkMean,gravityMean) |angletBodyGyroJerkMeangravityMean| mean(name) | Rational |
|86|559 |angle(X,gravityMean) |angleXgravityMean| mean(name) | Rational |
|87|560 |angle(Y,gravityMean) |angleYgravityMean| mean(name) | Rational |
|88|561 |angle(Z,gravityMean) |angleZgravityMean| mean(name) | Rational |


#### nameKey.txt
This text file was described above in detail and is provided for convenience to enable cross-referencing of the new transformed variable names in the tidy data with the original variable names.