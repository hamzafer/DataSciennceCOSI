# Set the seed for reproducibility
set.seed(1)

# Load necessary libraries
library(e1071)
library(readr)

# Load the wine dataset
wine_data <- read_csv("WineQT.csv")

# Assuming 'alcohol' is your target variable, create a training set
train_indices <- sample(1:nrow(wine_data), nrow(wine_data) / 2)

# Train the SVM model with a linear kernel
svmfit <- svm(alcohol ~ ., data = wine_data[train_indices,], kernel = "linear", cost = 10)

# Summarize the model
summary(svmfit)

# Ensure that 'alcohol' is extracted as a numeric vector, not as a tibble
actual_alcohol <- as.numeric(wine_data[-train_indices,][["alcohol"]])

# Predict using the SVM model on the test set
svmfit_predict <- predict(svmfit, newdata = wine_data[-train_indices,])

# Ensure the prediction is also a numeric vector
svmfit_predict <- as.numeric(svmfit_predict)

# Calculate and print the Root Mean Squared Error (RMSE)
rmse <- sqrt(mean((actual_alcohol - svmfit_predict)^2))
print(rmse)
