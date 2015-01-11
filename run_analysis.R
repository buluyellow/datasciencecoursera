subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")
y_train = read.table("UCI HAR Dataset/train/y_train.txt")
X_train = read.table("UCI HAR Dataset/train/X_train.txt")
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")
y_test = read.table("UCI HAR Dataset/test/y_test.txt")
X_test = read.table("UCI HAR Dataset/test/X_test.txt")

train = cbind(subject_train,y_train,X_train)
test = cbind(subject_test,y_test,X_test)
data = rbind(train,test)

features = read.table("UCI HAR Dataset/features.txt")
name = c("subject","activity",as.character(features$V2))
names(data) = name
expre = grep('subject|activity|mean\\(\\)|std\\(\\)',names(data))
cleandata1 = data[,expre]


activity = read.table("UCI HAR Dataset/activity_labels.txt")
translator = as.character(activity$V2)
names(translator) = activity$V1
cleandata1$activity = translator[cleandata1$activity]

cleandata2 = aggregate(cleandata1[-(1:2)],cleandata1[c('subject','activity')],mean)
write.table(cleandata2,"cleandata.txt",row.name=FALSE)
