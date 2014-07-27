Getting and Cleaning Data: Project Assignment
============================================

This is the repository for the Getting and Cleaning Data's class project assignment.



The dataset includes the following files:
=========================================

- README.md (This document. Explains what files are in the repo and how all the files are connected)

- Codebook.md (Explains how the data was cleaned and lists any relevant codes. Please refer to this file for more details on the cleaned data file.)

- run_analysis.R (Script that cleans the UCI_HAR data as per assignment instructions and outputs tidy data set to text file)


Script Notes:
=============

- The run_analysis.R script can be opened and run in R Studio and run and will clean the UCI_DAR data as long as the unzipped files are in your working directory as per class project insttructions.
- The script will check for the UCI_HAR data files to process and if not found will give an error with instructions.
- The run_analysis.R script uses the "reshape2" R library. It will check for the library and install if not found.

