## Code Book for run_analysis.R

1. **Setting the Working Directory:**
   - The code starts by setting the working directory using the `setwd()` function, providing the path to the directory where the data will be stored.

2. **Loading Required Libraries:**
   - The code loads the necessary libraries for data manipulation and tidying, namely `dplyr` and `tidyr`, using the `library()` function.

3. **Downloading and Unzipping the Data:**
   - The code downloads the dataset from the provided URL using the `download.file()` function, saving it to a specified destination.
   - The downloaded zip file is then extracted using the `unzip()` function.

4. **Merging Training and Test Data:**
   - The code reads the training and test data files using the `read.table()` function.
   - Training and test labels and subjects are read separately.
   - The training and test datasets are merged using the `rbind()` function, creating `merged_data`, `merged_labels`, and `merged_subjects` variables.

5. **Extracting Mean and Standard Deviation Measurements:**
   - The code reads the features file, which contains the names of the measurements, using the `read.table()` function.
   - Indices of the features containing mean and standard deviation are identified using `grep()` and stored in `mean_std_indices`.
   - The columns with mean and standard deviation measurements are extracted from `merged_data` using the indices obtained, resulting in `x_extracted`.

6. **Using Descriptive Activity Names:**
   - The code reads the activity labels file using the `read.table()` function.
   - The activity labels are transformed to lowercase, with underscores replaced by spaces.
   - Descriptive activity names corresponding to the activity labels in `merged_labels` are obtained and stored in `activity_names`.

7. **Labeling the Data Set with Descriptive Variable Names:**
   - The feature names extracted in Step 5 are cleaned up by removing parentheses using `gsub()`.
   - The columns of `x_extracted` are assigned the cleaned feature names as column names.
   - The `combined_data` dataset is created by combining `merged_subjects`, `activity_names`, and `x_extracted`.
   - The column names of `combined_data` are modified using multiple `gsub()` calls to make them more descriptive.

8. **Creating a Tidy Data Set with Averages:**
   - The code uses the `group_by()` function from `dplyr` to group the data by subject (`V1`) and activity names (`activity_names`).
   - The `summarise()` function is applied to calculate the mean of each variable across groups, using `across()` to apply it to all columns except the grouping ones.
   - The variable names "V1" and "activity_names" are renamed to "Subject" and "Activity Name", respectively, in the resulting `tidy_data`.
   - The `write.table()` function is used to write the `tidy_data` to a file named "tidy_data.txt" in the working directory, with `row.names = FALSE`.
