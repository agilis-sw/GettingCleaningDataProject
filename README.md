# GettingCleaningDataProject
Repo for "Getting and cleaning data" data science class project

## run_analysis.R documentation

### Input data structures

The input data consists of metadata that provides labels for the measurement variable columns (features.txt and activity_labels.txt), and the data itself which is in two groups (test and train), each vertically partitioned into three files having an identical number of rows with the row number implicitly linking the three vertical partitions: the measurements themselves, the subjects associated with the measurements, and the activities associated with the measurements.  There are multiple sets of measurements per activity / subject permutation.

### Output

See the accompanying codebook for a description of the variables in the tidy output file.  To summarize, there is one unique observation per activity / subject permutation, consisting of the mean of the subset of measurements pertaining to mean and standard deviations of all types of observations for which these are available.

### Algorithm

1. Preliminaries:  
  1. Determine the subset of features that are of interest, by grepping feature names in features.txt for "mean()" and "std()".
  2. Define user-friendly and machine-friendly labels for the activity_labels dataset's activity name and activity id respectively, so as to facilitate joining ("merging") with the preprocessed measurements on the activity id, and so the output has a human-friendly activity name value.
2. Get the preprocessed test and training data:  For each:
  1. Read the X data file containing the measurements per observation, vertically subset it to just the measurements of interest and attach the respective human-friendly labels (determined per step 1.1 above).
  2. Read the subject data file containing the subject id per observation and attach a human-friendly label
  3. Read the y data file containing the activity id per observation and label it with a name that exactly matches the name given to the activity id column in activity_labels in step 1.2 above.
  4. Join ("merge") the labeled y data with the activity_labels to produce a human-friendly activity file.
  5. Vertically concatenate ("cbind") the three tables obtained from 2.1, 2.2 and 2.4 to produce one table having the same number of rows and a union of all the columns and all human-friendly labels.
3. Horizontally concatenate ("rbind") the preprocessed test and training data rows to produce one table.
4. Now generate the output table:
  1. Melt the table by activity + subject so as to have, for each activity / subject combo, one row per measurement type.
  2. Cast the melted data so as to aggregate the melted rows with the "mean" function and produce a wide table having one variable per original measurement representing its respective mean.
  3. Write the resulting output to the run_tidydata.txt file.

