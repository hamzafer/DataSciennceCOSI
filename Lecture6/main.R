# Load glmnet library
library(glmnet)

# Prepare the data
x <- model.matrix(hp ~ . - 1, mtcars)  # No intercept
y <- mtcars[, 'hp']

# Create a grid of lambda values for Ridge regression
grid <- 10^seq(10, -2, length = 100)

# Fit the model
ridge.fit <- glmnet(x, y, alpha = 0, lambda = grid)

# Set options for displaying digits
options(digits = 2)

# View the coefficients
coef(ridge.fit)[, 1]

# Split the dataset into training and test sets
train <- sample(1:nrow(mtcars), nrow(mtcars) / 2)
test <- (-train)

# Perform cross-validation
cv.out <- cv.glmnet(x[train,], y[train], alpha = 0, nfolds = 5)

# Get the best lambda value
best.lambda <- cv.out$lambda.min

# Make predictions on the test set
prediction <- predict(ridge.fit, s = best.lambda, newx = x[test,])

# Calculate the mean squared error of the predictions
mean((prediction - y[test])^2)

# Refit the model on the full dataset with the best lambda
ridge.fit.final <- glmnet(x, y, alpha = 0)

# Make predictions using the final model
predict(ridge.fit.final, s = best.lambda, type = "coefficients")


#### Lasso Regression ####


# Perform cross-validation for Lasso regression
cv.out <- cv.glmnet(x[train,], y[train], alpha = 1, nfolds = 5)

# Get the best lambda value
best.lambda <- cv.out$lambda.min

# Fit the final Lasso model
ridge.fit.final <- glmnet(x, y, alpha = 1)

# Predict coefficients using the final model
predict(ridge.fit.final, s = best.lambda, type = "coefficients")
