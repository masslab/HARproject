HARproject
==========

repo for DSS Coursera Getting & Cleaning Data course project

README file for UCI HAR Data Cleanup
Version 1.0

November 20, 2014

written by S. Mass for JHSPH DSS Coursera 'Getting & Cleaning Data' course

## Overview
This readme file describes the  `run_analysis.R` script including the requirements for running the script, the data processing that occurs and the final output.

Please see the CodeBook for details on the data cleaning and transformations as well as the scope of the original project, the data set and the variables in the data.

### What `run_analysis.R` does
The script takes several separate data files from the UCI HAR data set and merges them into a single data set.  It then cleans the data by transforming the variable names into more a readable and intelligible form and replaces some numeric coding with natural language.  It then analyzes the results and produces a final tidy data set that presents a subset of grouped and aggregated data.

## Required Files, Environment & Packages
The following are required:

### Data Files
- The complete Human Activity Recognition Using Smartphones Dataset available from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- The Data Files should be in a subdirectory called `UCI HAR Dataset` in the working directory

### Scripts
- `run_analysis.R` script available on gitHub https://github.com/masslab/HARproject

- The script should be in the working directory

### Packages
`run_analysis.R` requires the following R packages:

- plyr
- dplyr

The script will check to see if they are installed.  If they are available it will load them.  If not it will install them automatically from CRAN.

## Variables & Data in `run_analysis.R`
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

- activityName [chr] vector containing activity labels from activity data frame
- activityNum [int] vector containing the numeric codes from activity data frame
- badNames [Factor] containing the original variable names from X_test (header)
- bigBodyNames [chr] used for removing 'BodyBody' typo from variable names
- bigfNames [chr] used for converting 'f' to 'FFT' in variable names
- bigGoodNames [chr] used for storing the entire 561 variables after transformations
- bigMeans [chr] used for converting 'mean' to 'Mean'
- bigNoPeriods [chr] used for removing internal periods and terminal elipes
- bigtNames [chr] used for converting 't' to 'Total' in variable names
- cols2 [chr] used for creating column headers in almostTidyData
- dots [List] used for aggregating final output
- legalNames [chr] holds output from `make.names()`
- namedActivities [chr] holds activities from activityName applied to entire data set
- newActivityCode [int] hold activity codes from entire data set before converting to names
- newSubjectCode [int] holds subject codes for entire data set
- reducedNames [chr] variable names used for mstd data frame used for nameKey

**Note** Many of the data frames and variables in the script are created to preserve intermediate processing steps and could have been eliminated (and would be if this was optimized).  They were left in the code to permit troubleshooting and debugging.  For example, almost all of the Name variables (bigBodyNames, bigfNames, bigtNames, etc) could have been collapsed into a single variable that is reused for each subsequent step.  Elegance and concision were not a priority over working code that was easy to debug.

## Data Processing
The code is well commented for following what's happening and why.  Here is a high level overview:

- check for `plyr` and `dplyr` packages.  Load or install as necessary.
- global data for variable names and activities are read into data frames
- test and train data files are read into data frames
- original variable names are extracted from features as 'badNames'
- `make.names()` is called to do a first pass cleanup on the variable names
  - this eliminates reserved R words (if any) and illegal characters (lots)
- variable names are further cleaned by replacing single letter prefixes with words using GREP (`gsub`)
- the 'BodyBody' typo is fixed in some of the variable names using GREP
- suffixes designating mean and std are capitalized using GREP
- artifacts from `make.names()` are removed using GREP (periods)
- `colnames` is used to assign the good names to the entire 561 variable test and train data sets
- test and train data sets are combined (train is appended to test using `rbind`)
- test and train subject data are combined in same way
- test and train activity data are combined in same way
- use dplyr to `select` only variables (columns) that have 'mean' or 'std'
- use dplyr `filter` to create nameKey for only those variables that are included in final data set
- recode the activity using plyr `mapvalues`
- `cbind` the activity and subject data to the data frame
- make an intermediate data frame (almostTidyData) that is grouped by activity and subject using `group_by`
- use `lapply` and dplyr `summarise` to calculate the averages of each variable by group
- create subdirectory to contain the output to working directory (tidyFiles)
- write final output: tidyData.txt
- write nameKey.txt

## Output
The script creates a tidy data set in wide format that is written to a file named 'tidyData.txt'.  The data set is 88 columns by 180 rows (and is described in detail in the CodeBook).  In addition, a file named 'nameKey.txt' is also written.  This is for cross-referencing the new variable names with their original names (and is also described in detail in the CodeBook).  Both files are written to a subdirectory named 'tidyFiles' which the script creates in the working directory.












