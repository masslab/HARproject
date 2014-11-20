# Code Book for UCI HAR Data Cleanup
Version 1.0

November 20, 2014

written by S. Mass for JHSPH DSS Coursera 'Getting & Cleaning Data' course

## Overview
This project required the creation of a script to perform general clean-up of the UCI HAR dataset, recombining several individual datasets contained therein, reduction of the scope and reorganization of the resulting dataset and then reporting aggregate data. The principle processing cleans-up and renames the variables in the data set (see below for details) and then subsets only the mean and standard deviation data to produce a reduced dimension aggregate data frame that contains means for each activity by each subject.


## Variables & Data
The following data frames are created by the script (in alphabetical order):

- activity (contains `activity_labels.txt`)
- AlmostTidyData (intermediate for creating final output)
- combinedDF (intermediate for creating `AmostTidyData`)
- features (contains `features.txt`)
- mstd (for mean and sd variables only)
- nameKey (a convenience feature for referencing new names to original names)
- newDF (combines the testing and training data)
- newFeatures (for making the `nameKey`)
- newSubject (for adding subjects to the combined data frame)
- newY (for adding the activities to the combined data frame)
- subject_test (for adding test subjects to `newSubject`)
- subject_train (for adding training subjects to `newSubject`)
- testDF (contains `X_test.txt`)
- tidyData (final output)
- trainDF (contains `X_train.txt`)
- y_test (contains `y_test.txt`)
- y_train (contains `y_train.txt`)

The following variables are created by the script (in alphabetical order):

- activityName
- activityNum
- badNames
- bigBodyNames
- bigfNames
- bigGoodNames
- bigMeans
- bigNoPeriods
- bigtNames
- cols2
- dots
- legalNames
- namedActivities
- newActivityCode
- newSubjectCode
- reducedNames

## Transformations & Processing
The following operations are performed:

#### Original Variable Names are Transformed
The variable names in the test and train data sets were changed according to the following rules:

1. `make.names()` was applied to remove reserved words and illegal characters

2. Leading 't' prefixes  were changed to 'Total'

3. Leading 'f' prefixes were changed to 'FFT' (for fast Fourier transform)

4. Trailing lowercase 'mean' was changed to 'Mean' for increased readability

5. Trailing lowercase 'std' was changed to 'STD for increased readability

6. The resulting variable names were 'cleaned' to remove internal periods and trailing elipses (some of these were artifacts of the `make.names()` operation)

7. Trailing 'X', 'Y', and 'Z' were maintained as terminal uppercase letters even though they sometimes decreased readability in order to preserve the cartesian coordinate pertaining to the variable.

##### Variable name key
The script creates a key called `nameKey.txt` which is part of the output (see Output below).  This key lists all 86 variables (columns) that are in the final data set as rows.  The first column indicates the original variable column number [1:561] while the second column contains the original name and the third column contains the transformed name. This is for convenience only and will permit the researcher/analyst to clearly understand which variables in the resulting output files correspond to which variables in the original data set.






## Output