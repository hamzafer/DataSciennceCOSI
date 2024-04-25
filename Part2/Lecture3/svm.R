library(e1071)
set.seed(1)
cat("\n***** new line", svmfit$index)
# Create a random dataset
x <- matrix(rnorm(20 * 2), ncol = 2)
y <- c(rep(-1, 10), rep(1, 10))
x[y == 1,] <- x[y == 1,] + 1
# Check whether the classes are linearly separable
plot(x, col = (3 - y))
# Create data.frame with factor class attribute
dat <- data.frame(x = x, y = as.factor(y))
# C is cost
svmfit <- svm(y ~ ., data = dat, kernel = "linear", cost = 0.10, scale = FALSE)
plot(svmfit, dat)
cat("Support vectors", svmfit$index)
summary(svmfit)

calculate_accuracy <- function(svm_model, data) {
  # Predict using the SVM model
  predictions <- predict(svm_model, data)
  # Actual labels
  actual_labels <- data$y
  # Calculate the number of correct predictions
  correct_predictions <- sum(predictions == actual_labels)
  # Calculate the total number of predictions
  total_predictions <- length(actual_labels)
  # Calculate accuracy
  accuracy <- correct_predictions / total_predictions
  # Return accuracy as a percentage
  return(accuracy * 100)
}

accuracy <- calculate_accuracy(svmfit, dat)
print(accuracy)

# e1071 automatic tuning
tune.out <- tune(svm, y ~ ., data = dat, kernel = "linear", ranges =
  list(cost = c(0.001, 0.01, 0.1, 1, 5, 10, 100)))
bestmod <- tune.out$best.model
summary(bestmod)

accuracy <- calculate_accuracy(bestmod, dat)
print(accuracy)

# Evaluate on test set
xtest <- matrix(rnorm(20 * 2), ncol = 2)
ytest <- sample(c(-1, 1), 20, rep = TRUE)
xtest[ytest == 1,] <- xtest[ytest == 1,] + 1
testdat <- data.frame(x = xtest, y = as.factor(ytest))

# Predictions with the best model
ypred <- predict(bestmod, testdat)
table(predict = ypred, truth = testdat$y)
