# Example with linear kernel
set.seed(1)
library(e1071)
data(iris)

calculate_accuracy <- function(svm_model, data) {
  # Predict using the SVM model
  predictions <- predict(svm_model, data = iris, type = "class")
  # Actual labels
  actual_labels <- data$Species
  # Calculate the number of correct predictions
  correct_predictions <- sum(predictions == actual_labels)
  # Calculate the total number of predictions
  total_predictions <- length(actual_labels)
  # Calculate accuracy
  accuracy <- correct_predictions / total_predictions
  # Return accuracy as a percentage
  return(accuracy * 100)
}

svmi <- svm(Species ~ ., data = iris, kernel = "linear", cost = 10)
svmi.predict <- predict(svmi, data = iris, type = "class")
table(svmi.predict, iris$Species)

accuracy <- calculate_accuracy(svmi, iris)
cat("linear ::", accuracy)

# Example with radial kernel
svmi <- svm(Species ~ ., data = iris, kernel = "radial", cost = 10)
svmi.predict <- predict(svmi, data = iris, type = "class")
table(svmi.predict, iris$Species)

accuracy <- calculate_accuracy(svmi, iris)
cat("radial ::", accuracy)

# Automatic OVO or OVA by svm - check which one it uses?

# Example with sigmoid kernel

svmi <- svm(Species ~ ., data = iris, kernel = "sigmoid", cost = 10)
svmi_predict <- predict(svmi, data = iris, type = "class")
table(svmi_predict, iris$Species)

accuracy <- calculate_accuracy(svmi, iris)
cat("sigmoid ::", accuracy)
