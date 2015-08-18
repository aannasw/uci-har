# uci-har
UCI Human Activity Recognition dataset analysis

UCI's Machine Learning Repository maintains a collection of datasets available to the machine learning community for analysis and research.

As a starting point for the use of data wrangling functions in R, the Johns Hopkins' [Getting and Cleaning Data](https://class.coursera.org/getdata-031) course offered on Coursera starts off with an assignment to perform various data table formatting, merging and summarizing functions on the [**UCI Human Activity Recognition Using Smartphones Data Set**] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

##### Assignment #####

1. Create an R script named `run_analysis.R` that performs the steps below
2. Merges the `x_`, `y_` and `subject_` data files that contain, respectively, the observations, the activities being recorded and the individual user/subject identifier
3. Merges the `train` and `test` datasets each of which contain a set of `x_`, `y_` and `subject_` data files
4. Assigns the appropriate column headers to all imported files
5. Matches up the activity descriptions with the activity numbers used in the `y_` data file
6. Of the 561 available columns, extract only the ones that contain `mean()` or `std()` in the column name
7. Tidy up the dataset, i.e. normalize as much as possible *and*
8. Create another smaller dataset with the average measurement when grouped by the subject identifier, the activity and the measured variable.

Finally, the `run_analysis.R` file, the datasets and a Readme file all go up on a github repository, thusly.

##### Solution Files #####

- `run_analysis.R`
- `README.md`
- `CodeBook.md` describing the variables, data and transformations used to arrive at the final solutions
- Solution dataset #1 in long format (normalized) - `HAR_tidy_dataset.txt`
- Solution dataset #2 with summary by subject, activity and measurement - `HAR_summary.txt`
- `\data\UCI HAR dataset\` with all the source files
