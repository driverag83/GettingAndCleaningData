CODEBOOK

As stated in the project instructions the run_analysis.R script performs the following steps in order to creat the final.txt file according to requirements.

a. Checks if file and directory exist, in case they dont it downloads file to the working directory.
b. Assign data to each variable
  1. features
  2. activities
  3. subject_test
  4. x_test
  5. y_test
  6. subject_train
  7. x_train
  8. y_train
c. Merges train and test datasets
  1. x - comes from merging x_train and x_test
  2. y - comes from merging y_train and y_test
  3. sub - comes from merging subject_test and subject_train
  4. data - comes from merging subject, x and y datasets
d. Create preliminar tidy dataset by selectin subject, code, mean and std columns from data
e. Replace numbers in code with activities variable and its names.
f. Rename variables accordingly
g. Create an independent tidy dataset with the average of each variable for each activity and subject
h. Export to final.txt
  
