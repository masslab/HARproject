# Code Book for UCI HAR Data Cleanup
Version 1.0

November 20, 2014

written by S. Mass for JHSPH DSS Coursera 'Getting & Cleaning Data' course

## Overview
This project required the creation of a script to perform general clean-up of the UCI HAR dataset, recombining several individual datasets contained therein, reduction of the scope and reorganization of the resulting dataset and then reporting aggregate data. The principle processing cleans-up and renames the variables in the data set (see below for details) and then subsets only the mean and standard deviation data to produce a reduced dimension aggregate data frame that contains means for each activity by each subject.

### Original Study Design
The original study used 30 test subjects performing six activities while wearing a Samsung Galaxy smartphone with an accelerometer and gyroscope.  Data were recorded during the activities to capture 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

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

**Note** The column headers in the final output (the variable names) are not identical to the names in `nameKey` in one respect only: the variable name is prepended by 'mean' and enclosed in parentheses to indicate that these are averages of that variable.

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

#### nameKey.txt
This text file was described above in detail and is provided for convenience to enable cross-referencing of the new transformed variable names in the tidy data with the original variable names.