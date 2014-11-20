# Code Book for UCI HAR Data Cleanup
Version 1.0

November 20, 2014

written by S. Mass for JHSPH DSS Coursera 'Getting & Cleaning Data' course

## Overview
This project required the creation of a script to perform general clean-up of the UCI HAR dataset, recombining several individual datasets contained therein, reduction of the scope and reorganization of the resulting dataset and then reporting aggregate data. The principle processing done cleans-up and renames the variables (see below for details) and then subsets only the mean and standard deviation data to produce a reduced dimension aggregate data frame that contains means for each activity by each subject.


## Required Files, Environment & Packages
The following are required files:

### Data Files
- The complete Human Activity Recognition Using Smartphones Dataset available from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- The Data Files should be in a subdirectory called `UCI HAR Dataset` in the working directory

### Scripts
- `run_analysis.R` script available on gitHub https://github.com/masslab/HARproject

- The script should be in the working directory

### Packages
`run_analysis.R` requires the following R packages:

- dplyr
- plyr

The script will check to see if they are installed.  If they are it will load them.  If not it will install them automatically from CRAN.

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


## Output