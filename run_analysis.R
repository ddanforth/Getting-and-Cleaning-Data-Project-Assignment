##File name: run_analysis.R

##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
## Check for package to perform end calculations, install if not found. Require package before moving forward.
packages <- c("reshape2")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

library(reshape2)
require("reshape2")


## FILE PREP
  ## Get current directory, setup paths to use.

   activities <- "activity_labels.txt"
   features <- "features.txt"
   x_test <-   "test/X_test.txt"
   y_test <-  "test/y_test.txt"
   sub_test <- "test/subject_test.txt"
   x_train <- "train/X_train.txt"
   y_train <- "train/y_train.txt"
   sub_train <- "train/subject_train.txt"
  
   allfiles <- c(activities, features, x_test, y_test, x_train, y_train, sub_test, sub_train)

  ## Check if files exist, if not given error message with instruction.
  
  for (i in 1:length(allfiles)) {
    if (!file.exists(allfiles[i])) {
      stop("\nMISSING DATA FILES: Your working directory must contain the data files and subdirectories. \nPlease download the .zip file, extract it, and set the resulting unzipped directory \nas your working directory.")
    }
  }
  
   print("Great, all files exist. Processing now, this might take a few minutes...")

## LINKING THE DATA
    
  ## Labels - Read in the label references for features and activities 
   featuresdf <- read.table(features, header = FALSE)
   actdf <- read.table(activities, header = FALSE)
   
  ## TEST - Read in all "test" data
  x_testdf <- read.table(x_test, header = FALSE)
  y_testdf <- read.table(y_test, header = FALSE) 
  sub_testdf <- read.table(sub_test, header = FALSE) 
   
   
  ## TRAIN - Read in all  "train" data
  x_traindf <- read.table(x_train, header = FALSE)
  y_traindf <- read.table(y_train, header = FALSE)
  sub_traindf <- read.table(sub_train, header = FALSE)
   
  ## Merge main "test" and "train" data, keeping activities & subjects separate for now.
   
  all_x <- rbind(x_testdf, x_traindf)
  all_y <- rbind(y_testdf, y_traindf)
  all_sub <- rbind(sub_testdf, sub_traindf)
   
  ## Clean up Activities & Subject headers before merging into a massive file 
   
  names(all_y) <- "Activity" 
  names(all_sub) <- "Subject" 
 
   # Swap out activity reference code with labels
   for (i in 1:nrow(actdf)) {
   
      icode <- all_y$Activity %in% actdf[i,1]   # Locate group by id number in the row
      ilabel <- actdf[i,2]
      all_y[icode, 1] <- as.character(ilabel)  # Swap code with its readable label
   
   }
   

  ## Clean up feature columns
   
   # Add feature names to columns first so we don't lose our place
   names(all_x) <- featuresdf[,2]
    
   # Find the features we'll want to keep and drop everything else
  
   featsave <- subset(featuresdf, grepl("*mean\\(\\)*|*std\\(\\)*", featuresdf[,2]))
   featlist <- as.vector(featsave[,2])
   all_x <- all_x[,featlist,drop=FALSE]
   
   # Loop through each header label in table and rename friendly based on keys
   
   oldheaders <- colnames(all_x) #save this
  
   for (i in 1:length(oldheaders)) {
     
     oldheader <- oldheaders[i]
     
     # Time vs frequency
     first <- substr(oldheaders[i], 1, 1)
     
     if (first=="t") { tf <- "Time" } 
     if (first=="f") { tf <- "Frequency" } 
     
     tempnew <- oldheaders[i]
     tempnew <- substring(tempnew, 2)
     
     # Accelerometer vs Gyroscope
     tempnew <- gsub("Acc", "Accelerometer-", tempnew)
     tempnew <- gsub("Gyro", "Gyroscope-", tempnew)
     
     # Body vs Gravity
     tempnew <- gsub("Body", "Body-", tempnew)
     tempnew <- gsub("Body-Body-", "Body-", tempnew) # Fix error in supplied data
     tempnew <- gsub("Gravity", "Gravity-", tempnew)
     
     # Mean or Standard Deviation
     tempnew <- gsub("-mean\\(\\)", "Mean", tempnew)
     tempnew <- gsub("-std\\(\\)", "StandardDeviation", tempnew)
     
     # Change Jerk and Magnitude
     tempnew <- gsub("Jerk", "Jerk-", tempnew)
     tempnew <- gsub("Mag", "Magnitude-", tempnew)

     
     #New Header
     newheader <- paste(tf, tempnew, sep="-")
     
     #Swap out old header with the new one
     
     names(all_x)[names(all_x) == oldheader] <- newheader
     
   }
   
   ## Append Activity & Subject data as a column to the results data.table
   
   all_df <- cbind(all_sub, all_y, all_x)   


  ## Start calulation of averages using reshape2 package
  
  all_melt <-  melt(all_df, id=c("Subject", "Activity"))

  output_df <- dcast(all_melt, Subject + Activity ~ variable,mean)
  

## WRITE
  ## Write out nice new clean data.table to .txt file
  ## Header plus each row on new line/carriage return with spaces in between each column field

  write.table(output_df, file = "UCI_HAR_clean_dataset.txt")

  print("Processing complete. Clean data file, UCI_HAR_clean_dataset.txt has been created.")
  



