library(MASS)
library(nnet)

# Load Boston housing data
data(Boston)

# Set a seed for reproducibility
set.seed(123)

# Split the data into training and test sets
train <- sample(1:nrow(Boston), nrow(Boston) / 2)

# Initialize variables to store best RMSE and corresponding size
best_size <- NA
best_rmse <- Inf

# Try different sizes of the neural network
sizes <- c(1, 2, 3, 5, 10, 50, 60)
# the error is getting better till 50 and then it is getting worse (overfitting)
# the best size is 50
for (size in sizes) {
  nn.boston <- nnet(medv ~ ., data = Boston, subset = train, size = size, linout = TRUE, trace = FALSE)

  # Make predictions on the test set
  nn.boston.predict.test <- predict(nn.boston, newdata = Boston[-train,])

  # Calculate RMSE for the test set
  rmse <- sqrt(mean((nn.boston.predict.test - Boston[-train, "medv"])^2))

  cat("Size:", size, "- RMSE on test set:", rmse, "\n")

  # If this model has the best RMSE, update best_size and best_rmse
  if (rmse < best_rmse) {
    best_rmse <- rmse
    best_size <- size
  }
}

# Print the best size and corresponding RMSE
cat("Best size:", best_size, "with RMSE:", best_rmse, "\n")
