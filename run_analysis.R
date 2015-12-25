library(utils)
library(reshape2)
library(plyr)
run_analysis = function() {
    # get feature labels and activity labels as vectors for appending to feature table before averaging
    measurement_labels=read.table("./data/features.txt")
    activity_labels=read.table("./data/activity_labels.txt")
    # Activity labels in the original metadata weren't labeled - label them.
    names(activity_labels)[1] = "activity_id"
    names(activity_labels)[2] = "activity"
    
    # get test and train feature data augmented with subject and activity, and create a merged data set
    findexes=grep("mean\\(\\)|std\\(\\)",measurement_labels$V2,value=FALSE)
    flabels=grep("mean\\(\\)|std\\(\\)",measurement_labels$V2,value=TRUE)
    testdata = getdata("test",findexes,flabels,activity_labels)
    traindata = getdata("train",findexes,flabels,activity_labels)
    alldata = rbind(testdata,traindata)
    
    #summarize, grouping by subject and activity
    alldatamelt = melt(alldata,id=c("activity","subject"),measure.vars=c(3:length(names(alldata))))
    tidydata=dcast(alldatamelt,activity+subject ~ variable, mean)
    
    #save the tidy data in a file
    if (!file.exists("./output")){dir.create("./output")}
    write.table(tidydata,"./output/run_tidydata.txt",col.names=TRUE,row.names=FALSE)
}

# getdata(): read and preprocess all the data for a given dataType (test / train), using
# the supplied feature labels and activity labels for human readability.
getdata = function(dataType,findexes,flabels,activity_labels) {
    # construct common file name prefix for all files of the given test / train type
    prefix=paste("./data/",dataType,"/",sep="")
    # construct common file name suffix for all files of the given test / train type
    suffix=paste("_",dataType,".txt",sep="")
    # get the X_*.txt file content  These are the actual, unlabeled observations.
    fdata = read.table(paste(prefix,"X",suffix,sep=""))
    # select just the columns of interest (the ones determined to correspond to  mean or std),
    # and label them with the names previously obtained from the features.txt file
    names(fdata)[findexes]=flabels
    fdatas = select(fdata, findexes)
    # get the subject_*.txt file content, label.  These are the subject IDs matching the
    # observations row-for-row.
    sdata = read.table(paste(prefix,"subject",suffix,sep=""))
    names(sdata)[1]="subject"
    # get the y_*.txt file content (which contains the activity ID's matching the observations
    # row-for-row, join with the activity_labels in order to obtain the human-readable activity description corresponding to the IDs
    adata = read.table(paste(prefix,"y",suffix,sep=""))
    names(adata)[1]="activity_id"
    adatas = select(merge(adata,activity_labels),activity)
    # create a single wide table having, for each observation, the subject ID, activity name, and just the specific measurement variables of interest
    return(cbind(adatas,sdata,fdatas))
}
