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
svmfit <- svm(y ~ ., data = dat, kernel = "linear", cost = 10, scale = FALSE)
plot(svmfit, dat)
cat("Support vectors", svmfit$index)
summary(svmfit)

# Predict using the SVM model
predictions <- predict(svmfit, dat)

# Actual labels
actual_labels <- dat$y

# Calculate the number of correct predictions
correct_predictions <- sum(predictions == actual_labels)

# Calculate the total number of predictions
total_predictions <- length(actual_labels)

# Calculate accuracy
accuracy <- correct_predictions / total_predictions

# Print accuracy
print(accuracy * 100)
