# Using the fgl dataset (MASS package), create an OVO classifier using LDA based binary classifiers.
library(MASS)
data(fgl)

# For the OVO strategy, we will create a binary classifier for each pair of classes.
# With 6 classes in this case, we have C(6, 2) = 6 * (6-1) / 2 = 15 binary classifiers.
# For each unique pair of classes (i, j), where i ≠ j and i, j ∈ {1 ... K}
# we create a binary classifier that distinguishes class i from class j.

# Function to perform Random Over Sampling
# This function takes a dataset and a target size, and adds samples to the dataset if it's smaller than the target size.
randomOverSampling <- function(dataset, targetSize) {
  additionalSamples <- vector()

  # Check if the dataset needs more samples to reach the target size
  if (nrow(dataset) < targetSize) {
    additionalSamples <- sample(nrow(dataset), targetSize - nrow(dataset), replace = TRUE)
  }

  # Append the additional samples to the original dataset
  augmentedDataset <- rbind(dataset, dataset[additionalSamples,])

  return(augmentedDataset)
}

# Function to select samples from two classes and balance them
selectAndBalanceClasses <- function(dataset, class1, class2, responseVariable) {
  responseColumnIndex <- which(colnames(dataset) == responseVariable)
  samplesOfClass1 <- dataset[dataset[, responseColumnIndex] == class1,]
  samplesOfClass2 <- dataset[dataset[, responseColumnIndex] == class2,]

  # Determine the majority and minority classes
  if (nrow(samplesOfClass1) > nrow(samplesOfClass2)) {
    majorityClassSamples <- samplesOfClass1
    minorityClassSamples <- samplesOfClass2
  } else {
    majorityClassSamples <- samplesOfClass2
    minorityClassSamples <- samplesOfClass1
  }

  # Balance the minority class to have the same number of samples as the majority class
  balancedMinorityClassSamples <- randomOverSampling(minorityClassSamples, nrow(majorityClassSamples))
  balancedDataset <- rbind(majorityClassSamples, balancedMinorityClassSamples)

  # Ensure the response variable only has the levels of interest
  balancedDataset[, responseColumnIndex] <- factor(balancedDataset[, responseColumnIndex], levels = c(class1, class2))

  return(balancedDataset)
}

# Prepare the data
set.seed(2)
originalDataset <- fgl
trainingSampleIndices <- sample(nrow(originalDataset), nrow(originalDataset) / 2)
trainingDataset <- originalDataset[trainingSampleIndices,]
testingDataset <- originalDataset[-trainingSampleIndices,]
responseVariableName <- "type"
responseVariableFormula <- as.formula(paste0(responseVariableName, "~ ."))

# Identify the response variable column and the number of levels (classes)
responseColumnIndex <- which(colnames(originalDataset) == responseVariableName)
numClasses <- length(levels(originalDataset[, responseColumnIndex]))

# Initialize a vector to hold predictions for One-Versus-One comparisons
predictionsMatrix <- rep(originalDataset[1, responseColumnIndex], nrow(testingDataset) *
  numClasses *
  (numClasses - 1) / 2)
dim(predictionsMatrix) <- c(nrow(testingDataset), numClasses * (numClasses - 1) / 2)

comparisonModelIndex <- 1

# Perform One-Versus-One class comparisons
for (i in 1:(numClasses - 1)) {
  for (j in (i + 1):numClasses) {
    class1Name <- levels(trainingDataset[, responseColumnIndex])[i]
    class2Name <- levels(trainingDataset[, responseColumnIndex])[j]

    balancedTrainingDataset <- selectAndBalanceClasses(trainingDataset, class1Name, class2Name, responseVariableName)

    # Remove constant variables within groups to avoid singularities - in our case it was variable number 8
    constantVariables <- sapply(balancedTrainingDataset[, -responseColumnIndex], function(x) length(unique(x)) == 1)
    if (any(constantVariables)) {
      balancedTrainingDataset <- balancedTrainingDataset[, !constantVariables]
      cat("Removed constant variables for group comparison:", class1Name, "vs", class2Name, "\n")
    }

    # Train the LDA model
    model <- lda(responseVariableFormula, data = balancedTrainingDataset)
    predictionsMatrix[, comparisonModelIndex] <- predict(model, testingDataset)$class
    comparisonModelIndex <- comparisonModelIndex + 1
  }
}

# Determine the most frequently predicted class for each test sample
finalPredictions <- rep(originalDataset[1, responseColumnIndex], nrow(testingDataset))

for (i in seq_len(nrow(testingDataset))) {
  finalPredictions[i] <- names(sort(table(predictionsMatrix[i,]), decreasing = TRUE))[1]
}

# Calculate and print the confusion matrix and accuracy
confusionMatrix <- table(finalPredictions, testingDataset[, responseColumnIndex])
print(confusionMatrix)

accuracy <- sum(diag(confusionMatrix)) / sum(confusionMatrix)
print(paste("Accuracy:", accuracy))

# [1] "Accuracy: 0.635514018691589"
