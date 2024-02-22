library(MASS)
library(ISLR)
library(class)
library(caret)
library(ROCR)

data("Default", package = "ISLR")
Default$default <- ifelse(Default$default == "Yes", 1, 0)
Default$student <- ifelse(Default$student == "Yes", 1, 0)

set.seed(123)
trainingIndex <- createDataPartition(Default$default, p = 0.7, list = FALSE)
trainingData <- Default[trainingIndex,]
testData <- Default[-trainingIndex,]
trainingData_scaled <- scale(trainingData[, -1])
testData_scaled <- scale(testData[, -1], center = attr(trainingData_scaled, "scaled:center"), scale = attr(trainingData_scaled, "scaled:scale"))

set.seed(123)
knn_pred_3 <- knn(train = trainingData_scaled, test = testData_scaled, cl = trainingData$default, k = 3)
knn_pred_5 <- knn(train = trainingData_scaled, test = testData_scaled, cl = trainingData$default, k = 5)

accuracy_k3 <- sum(testData$default == knn_pred_3) / length(knn_pred_3)
accuracy_k5 <- sum(testData$default == knn_pred_5) / length(knn_pred_5)

cat("Accuracy for K=3:", accuracy_k3, "\n")
cat("Accuracy for K=5:", accuracy_k5, "\n")

assessModel <- function(predictions, labels) {
  pred <- prediction(predictions, labels)
  plot(performance(pred, 'tpr', 'fpr'), colorize = TRUE)
  auc <- performance(pred, measure = "auc")
  cat("AUC:", attr(auc, "y.values")[[1]], "\n")
  cat("______________\n")
}

knn_pred_3_numeric <- as.numeric(knn_pred_3) - 1
knn_pred_5_numeric <- as.numeric(knn_pred_5) - 1
true_labels <- testData$default

cat("Model with K=3\n")
assessModel(knn_pred_3_numeric, true_labels)

cat("\nModel with K=5\n")
assessModel(knn_pred_5_numeric, true_labels)
