# Load the necessary libraries
library(ISLR)
library(ROCR)
library(class)
library(caret) # for data splitting

# Load the Default dataset
data("Default")

# Convert factors to numeric as KNN requires numerical values
Default$default <- as.numeric(Default$default == "Yes")
Default$student <- as.numeric(Default$student == "Yes")

# Scale numerical variables
Default$balance <- scale(Default$balance)
Default$income <- scale(Default$income)

# Set a seed for reproducibility
set.seed(2)

# Split the data into training and test sets
trainIndex <- createDataPartition(Default$default, p = 0.7, list = FALSE)
train.set <- Default[trainIndex, ]
test.set <- Default[-trainIndex, ]

# Choose different k values for the KNN classifier
k_values <- c(5, 20)

# Function to train KNN and assess the model
train_and_assess_knn <- function(train_data, test_data, k) {
  # Train the KNN classifier
  knn.pred <- knn(train_data[, -1], test_data[, -1], cl=train_data[, 1], k = k)

  # Convert predictions to binary
  knn.pred.numeric <- as.numeric(knn.pred == "Yes")

  # Create prediction object for ROCR
  pred <- prediction(knn.pred.numeric, test_data[, 1])

  # Calculate performance
  perf <- performance(pred, measure = "acc")
  acc <- max(slot(perf, "y.values")[[1]])

  # Calculate AUC
  perf.auc <- performance(pred, measure = "auc")
  auc <- slot(perf.auc, "y.values")[[1]]

  # Return the accuracy and AUC
  list(accuracy = acc, auc = auc)
}

# Assess KNN with different k values
results <- lapply(k_values, function(k) {
  train_and_assess_knn(train.set, test.set, k)
})

# Print the results
for (i in 1:length(k_values)) {
  cat("KNN with k =", k_values[i], "\n")
  cat("Accuracy:", results[[i]]$accuracy, "\n")
  cat("AUC:", results[[i]]$auc, "\n\n")
}
