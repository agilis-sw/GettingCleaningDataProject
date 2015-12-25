# Codebook For Coursera Getting-Cleaning-Data Project
VS
December 24, 2015

## Overview
The codebook describes the variables in the tidy data set that is generated from the <b>run_analysis.R</b> code.  

## Tidy Dataset Structure

The data set that is constructed is a <i>wide</i> dataset: each observation corresponds to a unique activity / subject permutation.  Associated with each observation, there is exactly one variable per aggregated mean across all instances of the raw measurements (whether X/Y/Z axis specific or non-directional) of a mean / standard deviation for the activity / subject in the raw data.  

This is acceptable as opposed to creating a narrow data set having "base measurement type" and "axis" and "aggregation type" columns, because:
(a) It corresponds most closely to what is being asked for, which is presumably based on the subsequent (and unstated) analytics processing requirement.  
(b) The resulting wide data is "dense", with no N/A values.  On the other hand, a narrow data set may have had a number of N/A values for the "axis" column since quite a few base measurements are non-directional.

## Variables

1. <b> activity </b>: a human-readable description of the activity.  This is the first part of the "key".  
2. <b> subject </b>: a unique numeric ID representing a specific subject.  This is the second part of the "key".  
3. For each measurement (including its directional aspect) and its measurement aggregation type, a variable having a name that is a concatenation of the base measurement type (eg. <b>tBodyGyro</b>), its original aggregation type (<b>mean()</b> or <b>std()</b>) and, for directional measurements, its axis (<b>X</b> / <b>Y</b> / <b>Z</b>), with '-' separator characters.  Complete examples:
 * <b>tBodyAcc-mean()-X</b>
 * <b>fBodyBodyGyroJerkMag-std()</b>
 
Note that the values of the observations in the resulting table represent the mean value of the corresponding mean / standard deviation measurements from the original data set.

## Further information

Refer to the inline comments in <b>run_analysis.R</b> as well as <b>README.md</b> for a description of the methodology used to produce the tidy data from the raw observations and associated metadata.
