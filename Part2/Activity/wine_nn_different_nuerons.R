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

# Initialize variables to store the best RMSE and corresponding size
best_size <- NA
best_rmse <- Inf

# Define a range of sizes to test
sizes <- c(1, 2, 3, 5, 10, 20, 30, 40, 50)

# Loop through each size to train the model and calculate RMSE
for (size in sizes) {
  nn_model <- nnet(quality ~ ., data = wine_data, subset = train_indices, size = size, linout = TRUE, trace = FALSE)

  # Predict on the training set
  nn_predict_train <- predict(nn_model, wine_data[train_indices,])
  actual_values_train <- wine_data[train_indices,][["quality"]]

  # Calculate RMSE for the training set
  rmse_train <- sqrt(mean((as.numeric(nn_predict_train) - actual_values_train)^2))

  # Predict on the testing set
  nn_predict_test <- predict(nn_model, newdata = wine_data[test_indices,])
  actual_values_test <- wine_data[test_indices,][["quality"]]

  # Calculate RMSE for the testing set
  rmse_test <- sqrt(mean((as.numeric(nn_predict_test) - actual_values_test)^2))

  # Output the size and RMSE for this model
  cat("Size:", size, "- RMSE on test set:", rmse_test, "\n")

  # Update best size and RMSE if this model is better
  if (rmse_test < best_rmse) {
    best_rmse <- rmse_test
    best_size <- size
  }
}

# Print the best size and corresponding RMSE
cat("Best size:", best_size, "with RMSE:", best_rmse, "\n")
