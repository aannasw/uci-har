The solution data set `HAR_tidy_dataset.txt` contains the following variables:

- `subject` - a numeric identifier for the user or subject being observed
- `actnum` - activity code identifier that matches up to an activity description such as 1 = Walking, 4 = Sitting, 5 = Standing etc.
- `actdesc` - description of activity being performed by the subject
- `features` - selected variables containing the mean() or std() of observed activity
- `measurement` - measured values

The solution data set `HAR_summary.txt` contains the following variables:

- `subject` - a numeric identifier for the user or subject being observed
- `actdesc` - description of activity being performed by the subject
- `features` - selected variables containing the mean() or std() of observed activity
- `avg_measurement` - average of measured values across time

#### Original dataset ####

Of the files included in the UCI HAR dataset.zip, we use the following files for this assignment:

- `activity_labels.txt` 
- `features.txt`
- `subject_test.txt` (`_test` files are in the 'test' folder in the original .zip file)
- `X_test.txt`
- `y_test.txt`
- `subject_train.txt` (`_train` files are in the 'train' folder in the original .zip file)
- `X_train.txt`
- `y_train.txt`

#### Structure ####

- Each of the `y_` files contain a single column with the activity code (1:6) of the activity being recorded
- Each of the `subject_' files contain a single column with a identifier code for the subject (i.e. user) being observed
- Each of the `x_` files contains 561 columns or variables with raw and summarized measurements from the various sensors
- The `_train` data, per the UCI source data page, contains data observed for the 70% of the volunteers selected for generating the training data. The `_test` data contains observations for the remaining 30%. 
- `features.txt` contains a list of 561 variable names that will be used to set the column names for the `x_` data files.

#### Data Transformations ####

1. The `activity_labels.txt` and `features.txt` descriptive tables are read into R
2. The following files are read into self-named variables in R: `subject_test.txt`, `X_test.txt`, `y_test.txt`, `subject_train.txt`, `X_train.txt`, and `y_train.txt`. 

  Since none of the files have row headers, the `subject_` and `y_` files are read in with manually specified column names, and the `X_` files are read in with column names mapped to the previously imported `features.txt`
3. Using `rbind()`, the test and train datasets for each of the x_, y_ and subject_ file types are appended together
4. Using `cbind()`, the newly combined `x_all`, `y_all` and `subj_all` data frames are attached together to form one data frame `har`
5. A subset of this dataset is mapped to `harSub` by selecting only the columns that contain the word 'mean' or 'std' (but not 'meanFreq'). To achieve this, we make use of the `select()` function.
6. Using the `merge()` function, we merge together the `harSub` dataframe with the `activity_labels` frame so that the data now includes descriptive identifiers for the activity being observed
7. The data frame is rearranged for better readability using the `select()` and `arrange()` functions, followed by converting a couple of columns from numeric to factor.
8. To create a *tidy* data set, the `gather()` function is used to pivot the data from a wide format to a long format. New columns 'features' and 'measurement' are created in the new data frame `harSubLong`.
9. Using chaining, the next step is to create a data table `harSummary` with the averages of the measured data, grouped by subject, activity and measured variable. We use the `summarise()`, `group_by()`, `ungroup()` and `arrange()` functions.
10. Finally, the two datasets are written to a text file using the `write.table()`
