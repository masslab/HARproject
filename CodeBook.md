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

**Note** The column headers in the final output (the variable names) are not identical to the names in `nameKey` in two respects: 
1. the variable name is prepended by 'mean' and enclosed in parentheses to indicate that these are averages of that variable
2. The Activity and Subject columns are not represented

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
| Col# |Var#  |  Original Name   |  New Name        | Displayed As | Values |
|:----|:----|:------------|:----------- |:------|:------|
|1 |NA | NA | Activity | Activity | 6 |
|2|NA | NA | Subject | Subject | 30 |
|3|1 |tBodyAcc-mean()-X |TotalBodyAccMeanX| mean() | Rational |
|4|2 |tBodyAcc-mean()-Y |TotalBodyAccMeanY| mean() | Rational | 
|5|3 |tBodyAcc-mean()-Z |TotalBodyAccMeanZ| mean() |  Rational |
|6|4 |tBodyAcc-std()-X |TotalBodyAccSTDX| mean() |  Rational |
|7|5 |tBodyAcc-std()-Y |TotalBodyAccSTDY| mean() |  Rational |
|8|6 |tBodyAcc-std()-Z |TotalBodyAccSTDZ| mean() |  Rational |
|9|41 |tGravityAcc-mean()-X |TotalGravityAccMeanX| mean() |  Rational |
|10|42 |tGravityAcc-mean()-Y |TotalGravityAccMeanY| mean() |  Rational |
|11|43 |tGravityAcc-mean()-Z |TotalGravityAccMeanZ| mean() |  Rational |
|12|44 |tGravityAcc-std()-X |TotalGravityAccSTDX| mean() |  Rational |
|13|45 |tGravityAcc-std()-Y |TotalGravityAccSTDY| mean() |  Rational |
|14|46 |tGravityAcc-std()-Z |TotalGravityAccSTDZ| mean() |  Rational |
|15|81 |tBodyAccJerk-mean()-X |TotalBodyAccJerkMeanX| mean() |  Rational |
|16|82 |tBodyAccJerk-mean()-Y |TotalBodyAccJerkMeanY| mean() |  Rational |
|17|83 |tBodyAccJerk-mean()-Z |TotalBodyAccJerkMeanZ| mean() |  Rational |
|18|84 |tBodyAccJerk-std()-X |TotalBodyAccJerkSTDX| mean() |  Rational |
|19|85 |tBodyAccJerk-std()-Y |TotalBodyAccJerkSTDY| mean() |  Rational |
|20|86 |tBodyAccJerk-std()-Z |TotalBodyAccJerkSTDZ| mean() | Rational |
|21|121 |tBodyGyro-mean()-X |TotalBodyGyroMeanX| mean() |  Rational |
|22|122 |tBodyGyro-mean()-Y |TotalBodyGyroMeanY| mean() |  Rational |
|23|123 |tBodyGyro-mean()-Z |TotalBodyGyroMeanZ| mean() |  Rational |
|24|124 |tBodyGyro-std()-X |TotalBodyGyroSTDX| mean() |  Rational |
|25|125 |tBodyGyro-std()-Y |TotalBodyGyroSTDY| mean() |  Rational |
|26|126 |tBodyGyro-std()-Z |TotalBodyGyroSTDZ| mean() |  Rational |
|27|161 |tBodyGyroJerk-mean()-X |TotalBodyGyroJerkMeanX| mean() |  Rational |
|28|162 |tBodyGyroJerk-mean()-Y |TotalBodyGyroJerkMeanY| mean() |  Rational |
|29|163 |tBodyGyroJerk-mean()-Z |TotalBodyGyroJerkMeanZ| mean() |  Rational |
|30|164 |tBodyGyroJerk-std()-X |TotalBodyGyroJerkSTDX| mean() |  Rational |
|31|165 |tBodyGyroJerk-std()-Y |TotalBodyGyroJerkSTDY| mean() |  Rational |
|32|166 |tBodyGyroJerk-std()-Z |TotalBodyGyroJerkSTDZ| mean() |  Rational |
|33|201 |tBodyAccMag-mean() |TotalBodyAccMagMean| mean() |  Rational |
|34|202 |tBodyAccMag-std() |TotalBodyAccMagSTD| mean() |  Rational |
|35|214 |tGravityAccMag-mean() |TotalGravityAccMagMean| mean() |  Rational |
|36|215 |tGravityAccMag-std() |TotalGravityAccMagSTD| mean() |  Rational |
|37|227 |tBodyAccJerkMag-mean() |TotalBodyAccJerkMagMean| mean() |  Rational |
|38|228 |tBodyAccJerkMag-std() |TotalBodyAccJerkMagSTD| mean()|  Rational |
|39|240 |tBodyGyroMag-mean() |TotalBodyGyroMagMean| mean() | Rational |
|40|241 |tBodyGyroMag-std() |TotalBodyGyroMagSTD| mean() | Rational |
|41|253 |tBodyGyroJerkMag-mean() |TotalBodyGyroJerkMagMean| mean() | Rational |
|42|254 |tBodyGyroJerkMag-std() |TotalBodyGyroJerkMagSTD| mean() | Rational |
|43|266 |fBodyAcc-mean()-X |FFTBodyAccMeanX| mean() | Rational |
|44|267 |fBodyAcc-mean()-Y |FFTBodyAccMeanY| mean() | Rational |
|45|268 |fBodyAcc-mean()-Z |FFTBodyAccMeanZ|mean() | Rational |
|46|269 |fBodyAcc-std()-X |FFTBodyAccSTDX|mean() | Rational |
|47|270 |fBodyAcc-std()-Y |FFTBodyAccSTDY|mean() | Rational |
|48|271 |fBodyAcc-std()-Z |FFTBodyAccSTDZ|mean() | Rational |
|49|294 |fBodyAcc-meanFreq()-X |FFTBodyAccMeanFreqX|mean() | Rational |
|50|295 |fBodyAcc-meanFreq()-Y |FFTBodyAccMeanFreqY|mean() | Rational |
|51|296 |fBodyAcc-meanFreq()-Z |FFTBodyAccMeanFreqZ|mean() | Rational |
|52|345 |fBodyAccJerk-mean()-X |FFTBodyAccJerkMeanX|mean() | Rational |
|53|346 |fBodyAccJerk-mean()-Y |FFTBodyAccJerkMeanY|mean() | Rational |
|54|347 |fBodyAccJerk-mean()-Z |FFTBodyAccJerkMeanZ|mean() | Rational |
|55|348 |fBodyAccJerk-std()-X |FFTBodyAccJerkSTDX|mean() | Rational |
|56|349 |fBodyAccJerk-std()-Y |FFTBodyAccJerkSTDY|mean() | Rational |
|57|350 |fBodyAccJerk-std()-Z |FFTBodyAccJerkSTDZ|mean() | Rational |
|58|373 |fBodyAccJerk-meanFreq()-X |FFTBodyAccJerkMeanFreqX|mean() | Rational |
|59|374 |fBodyAccJerk-meanFreq()-Y |FFTBodyAccJerkMeanFreqY|mean() | Rational |
|60|375 |fBodyAccJerk-meanFreq()-Z |FFTBodyAccJerkMeanFreqZ|mean() | Rational |
|61|424 |fBodyGyro-mean()-X |FFTBodyGyroMeanX|mean() | Rational |
|62|425 |fBodyGyro-mean()-Y |FFTBodyGyroMeanY|mean() | Rational |
|63|426 |fBodyGyro-mean()-Z |FFTBodyGyroMeanZ|mean() | Rational |
|64|427 |fBodyGyro-std()-X |FFTBodyGyroSTDX|mean() | Rational |
|65|428 |fBodyGyro-std()-Y |FFTBodyGyroSTDY|mean() | Rational |
|66|429 |fBodyGyro-std()-Z |FFTBodyGyroSTDZ|mean() | Rational |
|67|452 |fBodyGyro-meanFreq()-X |FFTBodyGyroMeanFreqX|mean() | Rational |
|68|453 |fBodyGyro-meanFreq()-Y |FFTBodyGyroMeanFreqY|mean() | Rational |
|69|454 |fBodyGyro-meanFreq()-Z |FFTBodyGyroMeanFreqZ|mean() | Rational |
|70|503 |fBodyAccMag-mean() |FFTBodyAccMagMean|mean() | Rational |
|71|504 |fBodyAccMag-std() |FFTBodyAccMagSTD|mean() | Rational |
|72|513 |fBodyAccMag-meanFreq() |FFTBodyAccMagMeanFreq|mean() | Rational |
|73|516 |fAccJerkMag-mean() |FFTBodyAccJerkMagMean|mean() | Rational |
|74|517 |fAccJerkMag-std() |FFTBodyAccJerkMagSTD|mean() | Rational |
|75|526 |fAccJerkMag-meanFreq() |FFTBodyAccJerkMagMeanFreq|mean() | Rational |
|76|529 |fGyroMag-mean() |FFTBodyGyroMagMean|mean() | Rational |
|77|530 |fGyroMag-std() |FFTBodyGyroMagSTD|mean() | Rational |
|78|539 |fGyroMag-meanFreq() |FFTBodyGyroMagMeanFreq|mean() | Rational |
|79|542 |fGyroJerkMag-mean() |FFTBodyGyroJerkMagMean|mean() | Rational |
|80|543 |fGyroJerkMag-std() |FFTBodyGyroJerkMagSTD|mean() | Rational |
|81|552 |fGyroJerkMag-meanFreq() |FFTBodyGyroJerkMagMeanFreq|mean() | Rational |
|82|555 |angle(tBodyAccMean,gravity) |angletBodyAccMeangravity|mean() | Rational |
|83|556 |angle(tBodyAccJerkMean),gravityMean) |angletBodyAccJerkMeangravityMean|mean() | Rational |
|84|557 |angle(tBodyGyroMean,gravityMean) |angletBodyGyroMeangravityMean|mean() | Rational |
|85|558 |angle(tBodyGyroJerkMean,gravityMean) |angletBodyGyroJerkMeangravityMean|mean() | Rational |
|86|559 |angle(X,gravityMean) |angleXgravityMean|mean() | Rational |
|87|560 |angle(Y,gravityMean) |angleYgravityMean|mean() | Rational |
|88|561 |angle(Z,gravityMean) |angleZgravityMean|mean() | Rational |


#### nameKey.txt
This text file was described above in detail and is provided for convenience to enable cross-referencing of the new transformed variable names in the tidy data with the original variable names.