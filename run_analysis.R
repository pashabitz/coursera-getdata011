loaddata <- function(dir, dataDir, fileSuffix, colNames, colsToLoad) {
  file <- paste('X', fileSuffix, sep = '')
  data <- read.table(paste(dataDir, file, sep = '/'))
  data <- data[, colsToLoad]
  colnames(data) <- colNames
  data <- mutate(data, r = as.numeric(rownames(data)))
  
  file <- paste('y', fileSuffix, sep = '')
  activities <- read.table(paste(dataDir, file, sep = '/'))
  activities <- mutate(activities, r = as.numeric(rownames(data)))
  
  data <- merge(activities, data, by = "r")
  
  labels <- read.table(paste(dir, 'activity_labels.txt', sep = '/'))
  data <- mutate(data, activity_name = factor(data$V1, levels = labels$V1, labels = labels$V2))
  
  file <- paste('subject', fileSuffix, sep = '')
  subjects <- read.table(paste(dataDir, file, sep = '/'))
  subjects <- mutate(subjects, r = as.numeric(rownames(subjects)))
  
  data <- merge(subjects, data, by = "r")
  data <- rename(data, subject = V1.x)
  data <- select(data, -r, -V1.y)
  data
}
runanalysis <- function(dir) {
  features <- read.table(paste(dir, 'features.txt', sep = '/'))
  stdFeatures <- grep("std", features$V2)
  meanFeatures <- grep("mean\\(\\)", features$V2)
  colsToLoad = c(stdFeatures, meanFeatures)
  stdNames <- as.character(features[stdFeatures, 2])
  meanNames <- as.character(features[meanFeatures, 2])
  colNames <- c(stdNames, meanNames)
  
  dataDir <- paste(dir, 'test', sep = '/')
  test <- loaddata(dir, dataDir, '_test.txt', colNames, colsToLoad)
  
  dataDir <- paste(dir, 'train', sep = '/')
  train <- loaddata(dir, dataDir, '_train.txt', colNames, colsToLoad)
  
  combined <- rbind(train, test)
  
  grouped <- group_by(combined, subject, activity_name)
  summary <- summarise_each(grouped, funs(mean))
}