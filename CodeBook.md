# Samsung Galaxy Phone accelerometer and compass experiment


Experiments were carried out on a group of 30 volunteers performing 6 activities (Walking, Walking upstairs, walking downstairs, sitting, standing, laying), by a team of researchers at the Smartlab - Non Linear Complex Systems Laboratory in Genoa, Italy.  Accelerometer and gyroscope data from Samsung Galaxy Phones were measured and processed to create a complex dataset of 'features' which might be used to differentiate the 6 different activities. 


## The original dataset
The feature dataset was a 561-feature vector with time and frequency domain variables. Each vector was effectively a sample of data derived from inertial signals taken from the phones, (since the current work focusses on these results rather than how the authors transformed the data from the RAW data, discussion of these details is out of scope - however you can read about the process in the Readme.txt file that comes with the dataset).  Thus we focus on the feature dataset.  The set was divided into training data and test data files.  Several feature vector samples were taken for each of the 6 activities for all 30 subjects. The Features represented triaxial measurements so there was an X, Y and Z component for each (shown by the XYZ postfix below).  The following patterns were estimated and included in this source dataset:

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

for these the following variables were estimated:
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Moving averages were also included:
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

Time domain signals were measured at a constant 50Hz.  Acceleration measurement were in standard gravity units 'g'.  Rotational velocity is measured in radians/second.


##The goal of this work was to provide a tidy dataset to summarize mean and std measurements taken in the original dataset against each of 30 users and the 6 activities they undertook in the experiment.

# Study Design
Read about the original study design in the details that come with the downloaded data.  The current work was only to process this data and present it in a succinct and tidy way.

# Processing choices
The RAW data was confusing: Codes were used to mark the 6 activities rather than clear names.  The available names werew captures in a separate 'activity_labels.txt' file which we used to join with the X_train.txt and X_test.txt data in order to provide descriptive activity types.  Furthermore colums in the datasets were numbered and the detailed description of each variable (see above) was captured in the 'features.txt' file (presumably because of the size of the dataset).  Because we were presenting only variables related to mean or standard deviations, we were able to include these names in our output file.

We opted to draw together the training and test datasets, initially separately, with the labelling mentioned above.  We then merged the sets into 'mergedSet' (within the script) and added a column called 'isTraining' to differentiate training and test data.  It is anticipated that this set will be most valuable for partitioning the data along different dimensions should further analyses be required.

The goal was to find averages for all mean and standard deviations in the dataset, and to partition by user (1-30) and activity(6). These columns are therefore contained in the dataset.

# Code Book
As mentioned above, all accelerations are in units of 'g' and rotational velocities in radians/second.

In Column order:
"user" - 1-30 user number
"activity" - LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
-- The following are all the mean and std measurements in the original dataset
"fBodyAcc.mean.X" 
"fBodyAcc.mean.Y" 
"fBodyAcc.mean.Z" 
"fBodyAcc.meanFreq.X" 
"fBodyAcc.meanFreq.Y" 
"fBodyAcc.meanFreq.Z" 
"fBodyAcc.std.X" 
"fBodyAcc.std.Y" 
"fBodyAcc.std.Z" 
"fBodyAccJerk.mean.X" 
"fBodyAccJerk.mean.Y" 
"fBodyAccJerk.mean.Z" 
"fBodyAccJerk.meanFreq.X" 
"fBodyAccJerk.meanFreq.Y" 
"fBodyAccJerk.meanFreq.Z" 
"fBodyAccJerk.std.X" 
"fBodyAccJerk.std.Y" 
"fBodyAccJerk.std.Z" 
"fBodyAccMag.mean." 
"fBodyAccMag.meanFreq." 
"fBodyAccMag.std." 
"fBodyBodyAccJerkMag.mean." 
"fBodyBodyAccJerkMag.meanFreq." 
"fBodyBodyAccJerkMag.std." 
"fBodyBodyGyroJerkMag.mean." 
"fBodyBodyGyroJerkMag.meanFreq." 
"fBodyBodyGyroJerkMag.std." 
"fBodyBodyGyroMag.mean." 
"fBodyBodyGyroMag.meanFreq." 
"fBodyBodyGyroMag.std." 
"fBodyGyro.mean.X" 
"fBodyGyro.mean.Y" 
"fBodyGyro.mean.Z" 
"fBodyGyro.meanFreq.X" 
"fBodyGyro.meanFreq.Y" 
"fBodyGyro.meanFreq.Z" 
"fBodyGyro.std.X" 
"fBodyGyro.std.Y" 
"fBodyGyro.std.Z" 
"tBodyAcc.mean.X" 
"tBodyAcc.mean.Y" 
"tBodyAcc.mean.Z" 
"tBodyAcc.std.X" 
"tBodyAcc.std.Y" 
"tBodyAcc.std.Z" 
"tBodyAccJerk.mean.X" 
"tBodyAccJerk.mean.Y" 
"tBodyAccJerk.mean.Z" 
"tBodyAccJerk.std.X" 
"tBodyAccJerk.std.Y" 
"tBodyAccJerk.std.Z" 
"tBodyAccJerkMag.mean." 
"tBodyAccJerkMag.std." 
"tBodyAccMag.mean." 
"tBodyAccMag.std." 
"tBodyGyro.mean.X" 
"tBodyGyro.mean.Y" 
"tBodyGyro.mean.Z" 
"tBodyGyro.std.X" 
"tBodyGyro.std.Y" 
"tBodyGyro.std.Z" 
"tBodyGyroJerk.mean.X" 
"tBodyGyroJerk.mean.Y" 
"tBodyGyroJerk.mean.Z" 
"tBodyGyroJerk.std.X" 
"tBodyGyroJerk.std.Y" 
"tBodyGyroJerk.std.Z" 
"tBodyGyroJerkMag.mean." 
"tBodyGyroJerkMag.std." 
"tBodyGyroMag.mean." 
"tBodyGyroMag.std." 
"tGravityAcc.mean.X" 
"tGravityAcc.mean.Y" 
"tGravityAcc.mean.Z" 
"tGravityAcc.std.X" 
"tGravityAcc.std.Y" 
"tGravityAcc.std.Z" 
"tGravityAccMag.mean." 
"tGravityAccMag.std."


