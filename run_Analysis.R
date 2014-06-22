library(base)
library(utils)
library(data.table)

# Read train data

ftrs  = read.table('./features.txt',header=FALSE); 
sub_train = read.table('./train/subject_train.txt',header=FALSE);
colnames(sub_train)  = "sub_id";
x_train   = read.table('./train/x_train.txt',header=FALSE); 
colnames(x_train)    = ftrs[,2]; 
y_train   = read.table('./train/y_train.txt',header=FALSE); 
colnames(y_train)    = "ac_id";
act_type  = read.table('./activity_labels.txt',header=FALSE);
colnames(act_type)  = c('ac_id','ac_type'); 

# Merge
train_data = cbind(y_train,sub_train,x_train);

# Read test data

sub_test = read.table('./test/subject_test.txt',header=FALSE);
colnames(sub_test)  = "sub_id";
x_test   = read.table('./test/x_test.txt',header=FALSE); 
colnames(x_test)    = ftrs[,2]; 
y_test   = read.table('./test/y_test.txt',header=FALSE); 
colnames(y_test)    = "ac_id";

# Merge
test_data = cbind(y_test,sub_test,x_test);

# Final data

final_data = rbind(train_data,test_data)



# Rename colums for Descriptive Names
column_names <- colnames(final_data)

column_names = gsub("\\()","",column_names)
column_names = gsub("-std$","StdDev",column_names)
column_names = gsub("-mean","Mean",column_names)
column_names = gsub("^(t)","time",column_names)
column_names = gsub("^(f)","freq",column_names)
column_names = gsub("([Gg]ravity)","Gravity",column_names)
column_names = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",column_names)
column_names = gsub("[Gg]yro","Gyro",column_names)
column_names = gsub("AccMag","AccMagnitude",column_names)
column_names = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",column_names)
column_names = gsub("JerkMag","JerkMagnitude",column_names)
column_names = gsub("GyroMag","GyroMagnitude",column_names)

setnames(final_data, column_names)

# extract columns for mean and std deviation

ext_columns <- grep(".*Mean.*|.*StdDev.*|.*ac_id.*|.*sub_id.*",column_names)
ext_data <- final_data[,ext_columns]

# create tidy data set

tidy_data=aggregate(final_data, by=list(activity = final_data$ac_id, subject=final_data$sub_id), mean)
tidy_data <- subset(tidy_data, select = -c(ac_id,sub_id) )
write.table(tidy_data,"tidy_data.txt",sep="\t")