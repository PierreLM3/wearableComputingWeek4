# Get all sets and extracts only the measurements on the mean and standard deviation for each measurement. 
# Read test csv files
x_test_csv <- read.fwf("UCI_HAR_Dataset/test/X_test.txt", widths = rep(16, times = 128))
subject_test_csv <- read.csv("UCI_HAR_Dataset/test/subject_test.txt", col.names = "subject_id", header = FALSE)
y_test_csv <- read.csv("UCI_HAR_Dataset/test/y_test.txt", col.names = "activity_id", header = FALSE)
x_test_csv <- x_test_csv %>% transform(MEAN=apply(x_test_csv,1, mean, na.rm = TRUE), SD=apply(x_test_csv,1, sd, na.rm = TRUE)) %>% select(MEAN, SD)

join_test <- cbind(subject_test_csv,y_test_csv, x_test_csv)

# Read train csv files
x_train_csv <- read.fwf("UCI_HAR_Dataset/train/X_train.txt", widths = rep(16, times = 128))
subject_train_csv <- read.csv("UCI_HAR_Dataset/train/subject_train.txt", col.names = "subject_id", header = FALSE)
y_train_csv <- read.csv("UCI_HAR_Dataset/train/y_train.txt", col.names = "activity_id", header = FALSE)
x_train_csv <- x_train_csv %>% transform(MEAN=apply(x_train_csv,1, mean, na.rm = TRUE), SD=apply(x_train_csv,1, sd, na.rm = TRUE)) %>% select(MEAN, SD)

join_train <- cbind(subject_train_csv,y_train_csv, x_train_csv)

# Join test and test observations
all_obs <- rbind(join_train, join_test)

# Add activity labels
activity_labels <- read.csv("UCI_HAR_Dataset/activity_labels.txt", header = FALSE, sep=" ", col.names = c("activity_id", "activity_label"))
all_obs_with_labels <- merge(all_obs, activity_labels, by = "activity_id", all.x = TRUE)
write.table(all_obs_with_labels,file= "output/obs_measurements.csv", row.names = FALSE)

# Get the average of each variable for each activity and each subject.
# Input dataframe must have four columns : subject_id, activity_label, MEAN, SD
grouped_by_obs <- all_obs_with_labels %>% group_by(subject_id, activity_label) %>% summarize(mean = mean(MEAN), sd = mean(SD))
write.table(grouped_by_obs,file= "output/grouped_by_obs.txt", row.names = FALSE)

