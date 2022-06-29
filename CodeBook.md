Input data from <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> are stored in UCI_HAR_Dataset.

After processing run_analysis.R script (in this repo), you will have 2 new files in the output dir :

-   obs_measurements.csv : for each observation, you will have 6 columns :

1.  id of the activity (int)
2.  id of the subject (int)
3.  mean of measurements (dbl)
4.  standard deviation of measurements (dbl)
5.  activity label (chr)

-   grouped_by_obs.txt : for each subject and each activity, you will have 4 columns :

1.  id of the subject (int)
2.  activity label (chr)
3.  mean (of all measurements for this subject and this activity) (dbl)
4.  mean of all standard deviations (dbl)
