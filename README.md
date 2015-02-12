# GettingAndCleaningData
for course project

Following files are present:
run_analysis.R
Codebook

What does run_analysis.R performs-

1. reads train datasets (trainset_X, trainset_Y, trainset_sub)
2. binds train datasets
3. reads test datasets (testset_X, testset_Y, testset_sub)
4. binds test datasets
5. reads 'activity lables' and 'features' datasets
6. binds both train and test datasets to train_test_set
7. Assign column names 'Activity' and 'Subject' columns to train_test_set
8. apply order to train_test_set
9. for each subject and activity, calculate average using loop
10 Write the mainFinalSet to file
