library(e1071)
set.seed(1)

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

x <- matrix(rnorm(200 * 2), ncol = 2)
x[1:100,] <- x[1:100,] + 2
x[101:150,] <- x[101:150,] - 2
y <- c(rep(1, 150), rep(2, 50))
dat <- data.frame(x = x, y = as.factor(y))

plot(x, col = y)

train <- sample(200, 100)
svmfit <- svm(y ~ ., data = dat[train,], kernel = "radial", gamma = 1, cost = 1)
plot(svmfit, dat[train,])

summary(svmfit)

svmfit <- svm(y ~ ., data = dat[train,], kernel = "radial", gamma = 1, cost = 1e5)
plot(svmfit, dat[train,])

accuracy <- calculate_accuracy(svmfit, dat)
print(accuracy)

########### Automatic tuning
tune.out <- tune(svm, y ~ ., data = dat[train,], kernel = "radial",
                 ranges = list(cost = c(0.1, 1, 10, 100, 1000), gamma = c(0.5, 1, 2, 3, 4)))

summary(tune.out)
summary(tune.out$best.model)

table(true = dat[-train, "y"], pred = predict(tune.out$best.model, newdata = dat[-train,]))

accuracy <- calculate_accuracy(tune.out$best.model, dat)
print(accuracy)


# the accuracy increase form 87.5 to 91 with automatic tuning
# the best model is best parameters:
#  cost gamma
#     1   0.5

# complexity summary(tune.out$best.model) - 30 support vectors out of 200
