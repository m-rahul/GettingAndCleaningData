 
  trainset_X<-c()
  trainset_y<-c()
  trainset_sub<-c()
  testset_X<-c()
  testset_y<-c()
  testset_sub<-c()
  final_trainset<-c()
  final_testset<-c()

  
  for (i in c("train","test")){
    filepath_X<-paste(getwd(),"/",i,"/","X_",i,".txt", sep="")
    filepath_y<-paste(getwd(),"/",i,"/","y_",i,".txt", sep="")
    filepath_sub<-paste(getwd(),"/",i,"/","subject_",i,".txt", sep="")
  
  #for reading Train and test data sets
    if (i=="train"){
      trainset_X<-read.table(filepath_X)
      trainset_y<-read.table(filepath_y)
      trainset_sub<-read.table(filepath_sub)
      
      # bind all columns together
      final_trainset<-cbind(trainset_sub, trainset_y, trainset_X)
    }
    else if (i=="test"){
      testset_X<-read.table(filepath_X)
      testset_y<-read.table(filepath_y)
      testset_sub<-read.table(filepath_sub)
      
      # bind all columns together
      final_testset<-cbind(testset_sub, testset_y, testset_X)
    }
      
  }
  activity_lbls<-as.list(read.table(paste(getwd(),"/","activity_labels.txt", sep="")))
  

  features<-read.table(paste(getwd(),"/","features.txt", sep=""))
  
  #bind both train and tet data sets
  train_test_set<-rbind(final_trainset,final_testset)
  
  colnames(train_test_set)[1]<-"Subject"
  colnames(train_test_set)[2]<-"Activity"
  
  #assign column names
  for (i in 1:nrow(features)+2) {
    if (i>=3){
      
      colnames(train_test_set)[i]<- as.character(features[i-2,2])
    }
  }
  
 
  train_test_set<-train_test_set[order(train_test_set[,1],train_test_set[,2],na.last=TRUE, decreasing=FALSE),]
  
  playTrainTest<-c()
  playSubject<-c()
  mainFinalSet<-data.frame()

  for (i in 1:30){
    # get data frame for each subject
      playTrainTest<-train_test_set[train_test_set$Subject==i,]
    for (j in 1:6){
      #get data frame for each activity
      playSubject<-playTrainTest[playTrainTest$Activity==j,]
      #get average value for each variable 
      if (j==1 && i==1){
        mainFinalSet<-rbind(colMeans(playSubject))
      }
      else{
        #store it separate Main data frame
        mainFinalSet<-rbind(mainFinalSet,colMeans(playSubject))  
      }
      
    }
  }
  write.table(mainFinalSet,file="FinalTidySet.txt",row.names=FALSE)
  