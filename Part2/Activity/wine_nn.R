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

# Ensure that predictions are numeric and that actual values are correctly extracted as numeric vectors
nn_predict_train <- as.numeric(predict(nn_model, wine_data[train_indices,]))
actual_values_train <- as.numeric(wine_data[train_indices,][["quality"]])

# Calculate the differences as a numeric vector
mean_value <- nn_predict_train - actual_values_train

# Calculate Root Mean Squared Error (RMSE) for the training set
rmse_train <- sqrt(mean(mean_value^2))

# Print the RMSE
cat("Root Mean Squared Error on training set:", rmse_train, "\n")

# Repeat for the testing set
nn_predict_test <- as.numeric(predict(nn_model, newdata = wine_data[test_indices,]))
actual_values_test <- as.numeric(wine_data[test_indices,][["quality"]])

# Calculate the differences for the test set
mean_value_test <- nn_predict_test - actual_values_test

# Calculate RMSE for the testing set
rmse_test <- sqrt(mean(mean_value_test^2))

# Print the RMSE
cat("Root Mean Squared Error on testing set:", rmse_test, "\n")
