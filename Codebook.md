Cleaned UCI_HAR Dataset Code Book
=================================

*Assignment:* Create a code book that describes the variables, the data, and any transformations or work you performed to clean up the data called CodeBook.md

##THE DATA##

- An R script "run_analysis.R" was created to programatical clean the data as per project instrucitons. 
- The program links and merges the orignial UCI_HAR data into a master observation table.
- It extracts only the "mean()" and "std()" observation for processing.
- UCI_HAR Labels were renamed to be more readable and desciptve as per assignment .
- A second, clean, data set was created with the averages of each feature for each activity and each subject.
- The resuting "tidy" data is in a text file and contains a table with *68 columns* and *180 rows* (not including headers).
- The tidy data file name is, *UCI_HAR_clean_dataset.txt* and can be reproduced by the "run_analysis.R" script.
- The tidy data set text file is space delimited with a quotation marks as the text qualifier.

##DATA CLEANING PROCESS##

1. The orignial UCI_HAR files were read in and X_train.txt was appended to the X_test.txt in a master observation table

2. Following the orignal UCI_HAR schema, the features.txt data was added to the master observation table as column headers.

3. After associating features to correct columns, features OTHER THAN "mean()" & "std()" were DROPPED from master table. This left 66 features plus the "Activity" and "Subject" columns to make 68 columns.

4. The original headers were renanamed to be more readable (tidy/user friendly):
-The UCI_HAR data "t" & "f" variables were expanded to "Time" and "Frequency" respectively.
-Acc and Gyro were replaced with the full terms "Accelerator" and "Gyroscope"
-The erronious "Body-Body" naming at the end of the file was resolved to comply with original UCI_HAR scheme.
-The "mean()" and "std()" measurement naming was expanded to "Mean" and "StandardDeviation" respectively.
-The "Mag" measurement indicator was expanded to "Magnitude"
-Each element of the naming scheme was concatuated by hypens "-" to remove spaces and simplify data import.
-The resulting naming schema parallels the original UCI_HAR data scheme but is more readable and is as follows:
-- Time or Frequency
-- Accelerometer or Gyroscope
--  Body or Gravity
-- Mean or Standard Deviation
--Jerk or Magnitude
--X, Y, or Z axis
--Example Renamed Feature: *Time-Body-Accelerometer-Mean-X*

5. Next the activity labels were read in from activity_labels.txt and referenced by ID in the master observation table with the header "Activity"

6. Each activity ID was swapped out for its readable name in the obeservation table to be easier to read (tidy).

7. The subjects were added to their corresponding observations in the master observation table with the header "Subject"
	
8. Using the "reshape2" package, the master data table observations were summarized by Subject and Activity, giving the average/mean for each feature in the table as per the class assignment instructions. 
..1. The resulting clean data table as per instructions is *68 columns with *180 rows.

9. Once the data itself was clean and readable, it was saved to a delimited text file with commas indicating charachter fields.
..1. The text file is easily read into another script for future processing. 
..2. The R script duplicates the above outlined process and programattically creates the clean data. 
	
##DATA VARIABLES##

Below is the full list of data variables: 

###Activity - The activity performed by the subject###
- WALKING

- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING

- STANDING

- LAYING


###Subject - The participant (person) being measured###
- A unique number 1 - 30 for each participant
- Only summary averages for each participant's Mean and Standard Deviation are shown for each activity.

###Feature Averages###
- *Each feature below represents the mean/average for all the observations of that feature for each subject and each activity*
- Time-Body-Accelerometer-Mean-X
- Time-Body-Accelerometer-Mean-Y
- Time-Body-Accelerometer-Mean-Z
- Time-Body-Accelerometer-StandardDeviation-X
- Time-Body-Accelerometer-StandardDeviation-Y
- Time-Body-Accelerometer-StandardDeviation-Z
- Time-Gravity-Accelerometer-Mean-X
- Time-Gravity-Accelerometer-Mean-Y
- Time-Gravity-Accelerometer-Mean-Z
- Time-Gravity-Accelerometer-StandardDeviation-X
- Time-Gravity-Accelerometer-StandardDeviation-Y
- Time-Gravity-Accelerometer-StandardDeviation-Z
- Time-Body-Accelerometer-Jerk-Mean-X
- Time-Body-Accelerometer-Jerk-Mean-Y
- Time-Body-Accelerometer-Jerk-Mean-Z
- Time-Body-Accelerometer-Jerk-StandardDeviation-X
- Time-Body-Accelerometer-Jerk-StandardDeviation-Y
- Time-Body-Accelerometer-Jerk-StandardDeviation-Z
- Time-Body-Gyroscope-Mean-X
- Time-Body-Gyroscope-Mean-Y
- Time-Body-Gyroscope-Mean-Z
- Time-Body-Gyroscope-StandardDeviation-X
- Time-Body-Gyroscope-StandardDeviation-Y
- Time-Body-Gyroscope-StandardDeviation-Z
- Time-Body-Gyroscope-Jerk-Mean-X
- Time-Body-Gyroscope-Jerk-Mean-Y
- Time-Body-Gyroscope-Jerk-Mean-Z
- Time-Body-Gyroscope-Jerk-StandardDeviation-X
- Time-Body-Gyroscope-Jerk-StandardDeviation-Y
- Time-Body-Gyroscope-Jerk-StandardDeviation-Z
- Time-Body-Accelerometer-Magnitude-Mean
- Time-Body-Accelerometer-Magnitude-StandardDeviation
- Time-Gravity-Accelerometer-Magnitude-Mean
- Time-Gravity-Accelerometer-Magnitude-StandardDeviation
- Time-Body-Accelerometer-Jerk-Magnitude-Mean
- Time-Body-Accelerometer-Jerk-Magnitude-StandardDeviation
- Time-Body-Gyroscope-Magnitude-Mean
- Time-Body-Gyroscope-Magnitude-StandardDeviation
- Time-Body-Gyroscope-Jerk-Magnitude-Mean
- Time-Body-Gyroscope-Jerk-Magnitude-StandardDeviation
- Frequency-Body-Accelerometer-Mean-X
- Frequency-Body-Accelerometer-Mean-Y
- Frequency-Body-Accelerometer-Mean-Z
- Frequency-Body-Accelerometer-StandardDeviation-X
- Frequency-Body-Accelerometer-StandardDeviation-Y
- Frequency-Body-Accelerometer-StandardDeviation-Z
- Frequency-Body-Accelerometer-Jerk-Mean-X
- Frequency-Body-Accelerometer-Jerk-Mean-Y
- Frequency-Body-Accelerometer-Jerk-Mean-Z
- Frequency-Body-Accelerometer-Jerk-StandardDeviation-X
- Frequency-Body-Accelerometer-Jerk-StandardDeviation-Y
- Frequency-Body-Accelerometer-Jerk-StandardDeviation-Z
- Frequency-Body-Gyroscope-Mean-X
- Frequency-Body-Gyroscope-Mean-Y
- Frequency-Body-Gyroscope-Mean-Z
- Frequency-Body-Gyroscope-StandardDeviation-X
- Frequency-Body-Gyroscope-StandardDeviation-Y
- Frequency-Body-Gyroscope-StandardDeviation-Z
- Frequency-Body-Accelerometer-Magnitude-Mean
- Frequency-Body-Accelerometer-Magnitude-StandardDeviation
- Frequency-Body-Accelerometer-Jerk-Magnitude-Mean
- Frequency-Body-Accelerometer-Jerk-Magnitude-StandardDeviation
- Frequency-Body-Gyroscope-Magnitude-Mean
- Frequency-Body-Gyroscope-Magnitude-StandardDeviation
- Frequency-Body-Gyroscope-Jerk-Magnitude-Mean
- Frequency-Body-Gyroscope-Jerk-Magnitude-StandardDeviation


