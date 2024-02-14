# Create all the possible linear models with 2 variables to predict the hp value using the mtcars data-set.
# Show the mean squared train error of each model and find the model with the lowest value.

data <- mtcars

target_var <- "hp"
predictors <- c("mpg", "cyl", "disp", "drat", "wt", "qsec", "vs", "am", "gear", "carb")

n_vars <- 2
combinations <- combn(predictors, n_vars, simplify = FALSE)

fit_model_and_calculate_mse <- function(combination) {
  formula_str <- paste(target_var, "~", paste(combination, collapse = "+"))
  formula <- as.formula(formula_str)
  model <- lm(formula, data = data)
  mse <- mean((predict(model, data) - data[[target_var]])^2)
  list(formula = formula_str, mse = mse)
}

results <- lapply(combinations, fit_model_and_calculate_mse)

min_mse_index <- which.min(sapply(results, function(x) x$mse))
min_mse_model <- results[[min_mse_index]]

cat("\nModel with the lowest MSE:\n")
cat(min_mse_model$formula, "MSE:", min_mse_model$mse, "\n")

# find the model with the lowest value
#   Model with the lowest MSE:
#   hp ~ disp+carb MSE: 672.6718
