# Assuming 'logit.model' is a logistic regression model fitted on some data not shown in the image

# Generate a sequence of values for predictors
x1 <- seq(min(range(Default$balance)), max(range(Default$balance)), length.out = 100)
x2 <- seq(min(range(Default$income)), max(range(Default$income)), length.out = 100)

# Create a grid of values for the predictors
grid <- expand.grid(x1, x2)

# Prepare a new data frame for prediction
test <- data.frame(balance = grid[, 1], income = grid[, 2])

# Predict probabilities using the logistic regression model
logit.probs <- predict(logit.model, newdata = test, type = "response")

# Classify as '1' or '0' based on the predicted probability
logit.preds <- ifelse(logit.probs > 0.5, "1", "0")

# Convert predictions to a matrix for contour plotting
result <- matrix(as.numeric(logit.preds), length(x1), length(x2))

# Plot the contour
contour(x1, x2, result, levels = 0.5)

# Add points to the plot
points(test, pch = ".", col = ifelse(result == '0', "red", "green"))
points(x = Default[train,]$balance, y = Default[train,]$income, col = ifelse(Default[train,]$default == 'No', "red", "green"))
