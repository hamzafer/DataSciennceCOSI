# Create all the possible linear models with 2 variables to predict the hp value using the mtcars data-set.
# Show the mean squared train error of each model and find the model with the lowest value.

data <- mtcars

target_var <- "hp"
predictors <- c("mpg", "cyl", "disp", "drat", "wt", "qsec", "vs", "am", "gear", "carb")

n_vars <- 2
combinations <- combn(predictors, n_vars, simplify = FALSE)

calculate <- function(sign = "+", intercept = FALSE) {

  additive_fit_model_and_calculate_mse <- function(combination) {
    formula_str <- paste(target_var, "~", paste(combination, collapse = sign))
    if (intercept) {
      formula_str <- paste0(formula_str, " - 1")
    }
    formula <- as.formula(formula_str)
    model <- lm(formula, data = data)
    mse <- mean((predict(model, data) - data[[target_var]])^2)
    list(formula = formula_str, mse = mse)
  }

  results <- lapply(combinations, additive_fit_model_and_calculate_mse)

  min_mse_index <- which.min(sapply(results, function(x) x$mse))
  return(min_mse_model <- results[[min_mse_index]])
}

min_mse_model_additive <- calculate("+")
min_mse_model_non_additive <- calculate("*")
min_mse_model_additive_intercept <- calculate("+", TRUE)
min_mse_model_non_additive_intercept <- calculate("*", TRUE)

cat("\nModel with the lowest MSE Additive:\n")
cat(min_mse_model_additive$formula, "MSE:", min_mse_model_additive$mse, "\n")

cat("\nModel with the lowest MSE Non Additive:\n")
cat(min_mse_model_non_additive$formula, "MSE:", min_mse_model_non_additive$mse, "\n")

cat("\nModel with the lowest MSE Additive with Intercept:\n")
cat(min_mse_model_additive_intercept$formula, "MSE:", min_mse_model_additive_intercept$mse, "\n")

cat("\nModel with the lowest MSE Non Additive with Intercept:\n")
cat(min_mse_model_non_additive_intercept$formula, "MSE:", min_mse_model_non_additive_intercept$mse, "\n")

# find the model with the lowest value
#   Model with the lowest MSE:
#   hp ~ disp+carb MSE: 672.6718
