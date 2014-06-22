
The assumption is the train and test data as well as other related data has been extracted in a current data set directory. eg. C:\certificate_courses\Getting_and_Cleaning_Data\uci_har_dataset

The run_Analyis.R does the following:

1. Reads the train and test data , combines columnar data for each data set and then combines row data for both test sets.

2. Then the final column names are renamed to descriptive names using the grep function for substitution

3. Next we extract columns for the mean and standard deviation using the grep function and then extract related columnar data for only mean and std deviation

4. Next we store the final tidy data after aggregation for acct id and subject id