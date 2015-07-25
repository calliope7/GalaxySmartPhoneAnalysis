# GalaxySmartPhoneAnalysis

This analysis is based on the Human Activity Recognition Using Smartphones Dataset by
Jorge L. Reyes-Ortiz et all from the Smartlab - Non Linear Complex Systems Laboratory in Genoa, Italy.

The goal of this work is to merge their dataset of training and test data into one tidy dataset that contains average values for means and standard deviation data against each of 30 users, partitioned by 6 activities: Laying, Sitting, Standing, Walking, Walking Downstairs & Walking Upstairs.

There are 4 files in this repo.

1. README.md - which you are currently reading.  Provides a description of how all the files fit together.

2. run_analysis.R  - This is the only R script who's purpose is to: a) download the dataset from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", b) Extract both the training set and test set, retain only mean and standard deviation data, label activities according to the proper names, label data fields, and merge the data sets by injecting a new column called 'isTraining' so that it is possible to trace the purpose of the data : the result we call the 'mergedSet', c) We use the 'mergedSet' then to create the 'aveSet' which averages values grouped according to each of the 30 users and for each of the 6 activities.  In this case no differentiation is made between training and test data so we do not carry forward the 'isTraining' column to this dataset, d) Finally we output this final dataset as 'SamsungGalaxyMeanStdResults.txt'

3. SamsungGalaxyMeanStdResults.txt - this is the output file mentioned in #3.

4. CodeBook.md - which describes the steps to analyse the data along with output and units.

# Running the script
To use this code: 
1. Set your R working directory to point to the directory with run_analysis.R.  
2. type: source("run_analysis.R").  This will download the datafile, timestamp it, and name it: <timestamp>Dataset.zip in a newly created "data" directory within the current directory.  All analysis will follow, and the resulting averages and standard deviation dataset will be written to the current directory.  Re-running the script will create a new download file (thanks to the timestamp) so that we can always keep track of the time the analysis was created. Note that the script does not unzip the file into another directory but reads directly from the zipped source file.  This keeps your directories tidy and the analysis clean.
