# Load required libraries
library(nnet)  # For neural network functions
library(readr) # For reading CSV files

# Load your dataset
wine_data <- read_csv("WineQT.csv")

# Check the names of the columns to identify the target variable
print(colnames(wine_data))

# Assuming the target variable is named 'quality'
set.seed(123)

# Split data into training and testing sets
train_indices <- sample(1:nrow(wine_data), nrow(wine_data) / 2)
test_indices <- setdiff(1:nrow(wine_data), train_indices)

# Train the neural network
nn_model <- nnet(quality ~ ., data = wine_data, subset = train_indices, size = 5, linout = TRUE)

# Make predictions on the training set
nn_predict_train <- predict(nn_model, wine_data[train_indices,])

# Calculate Root Mean Squared Error (RMSE) for training set
rmse_train <- sqrt(mean((nn_predict_train - wine_data[train_indices, "quality"])^2))

# Make predictions on the testing set
nn_predict_test <- predict(nn_model, newdata = wine_data[test_indices,])

# Calculate RMSE for testing set
rmse_test <- sqrt(mean((nn_predict_test - wine_data[test_indices, "quality"])^2))

# Print mean squared errors
cat("Mean squared error on training set:", rmse_train, "\n")
cat("Mean squared error on test set:", rmse_test, "\n")
