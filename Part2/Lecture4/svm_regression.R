# Example with linear kernel
set.seed(1)
library(e1071)
data(iris)
library(MASS)
data(Boston)

# Load the Boston housing dataset
data(Boston)

# Create a training set
train <- sample(1:nrow(Boston), nrow(Boston)/2)

# Train the SVM model with a linear kernel
svmfit <- svm(medv ~ ., data=Boston[train,], kernel="linear", cost=10)

# Summarize the model
summary(svmfit)

# Predict using the SVM model on the test set
svmfit.predict <- predict(svmfit, newdata=Boston[-train,])

# Calculate and print the Root Mean Squared Error (RMSE)
rmse <- sqrt(mean((Boston[-train, "medv"] - svmfit.predict)^2))
print(rmse)

# Automatic Regression with SVM
# Compare with Random Forest
# Find some other kernels
# Specilized kernels
# Kernels for images
