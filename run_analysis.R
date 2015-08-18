setwd("/Users/Arti/R")

# 0. Load up the required packages
library(dplyr)
library(tidyr)

# 1. Read in Activity Labels and Features list

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt"
                              , header = FALSE, col.names = c("actnum", "actdesc"))
features <- read.table("./data/UCI HAR Dataset/features.txt"
                       , header = FALSE, col.names = c("colnum","coldesc"))

# 2. Read in subject_train, X_train and y_train

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "subject")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE, col.names = features$coldesc)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", sep = " ", header = FALSE, col.names = "actnum")

# 3. Read in subject_test, X_test, y_test

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "subject")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE, col.names = features$coldesc)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE, col.names = "actnum")

# 4. Combine the test and training data sets (x_test and x_train)

x_all <- rbind(x_train, x_test)
y_all <- rbind(y_train, y_test)
subj_all <- rbind(subject_train, subject_test)

# 5. Combine x_all, y_all and subj_all to create a new data frame 'har' (Human Activity Recognition) dataset

har <- cbind(subj_all, y_all, x_all)

# 6. Clean up all interim data frames

rm(subject_test, subject_train, x_test, x_train, y_test, y_train)
rm(x_all, y_all, subj_all)

# 7. Create a data frame with only mean and stdev for each measurement
# TESTING: filter(features, grepl('mean', coldesc), !grepl('meanFreq', coldesc)) ; filter(features, grepl('std', coldesc))

harSub <- select(har, subject, actnum, contains("mean"), contains("std"), -contains("meanFreq"))

# 8. Apply descriptive names for the activity variable. Rearrange and sort columns.

harSub <- merge(harSub, activity_labels, by = "actnum")

harSub <- harSub %>% 
  select(2, 1, 76, 3:75) %>% 
  arrange(subject, actnum)

harSub$subject <- as.factor(harSub$subject)
harSub$actnum <- as.factor(harSub$actnum)

# 9. Create a 'tidy' dataset

harSubLong <- harSub %>% 
  gather("features", "measurement", 4:76)  # glimpse(harSubLong)

# 10. Summarise

harSummary <- harSubLong %>% 
  group_by(subject, actdesc, features) %>% 
  summarise(avg_measurement = mean(measurement)) %>% ungroup() %>% ungroup() %>% 
  arrange(subject, actdesc, features)

# 11. SOLUTIONS

head(harSubLong) # "Tidy" dataset in long format - 751827 obs. of 5 variables

head(harSummary) # Summarized by subject, activity and variable - 13140 obs. of 4 variables

# 12. Write dataset to file

write.table(harSubLong, file = "HAR_tidy_dataset.txt", quote = FALSE
            , sep = " ", row.names = FALSE, col.names = TRUE)

write.table(harSummary, file = "HAR_summary.txt", quote = FALSE
            , sep = " ", row.names = FALSE, col.names = TRUE)