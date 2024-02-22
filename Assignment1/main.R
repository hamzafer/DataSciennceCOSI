# Create all the possible linear models with 2 variables to predict the hp value using the mtcars data-set.
# Show the mean squared train error of each model and find the model with the lowest value.

data <- mtcars

target_var <- "hp"
predictors <- c("mpg", "cyl", "disp", "drat", "wt", "qsec", "vs", "am", "gear", "carb")
# subtracting vs and am because they are binary variables
predictors_poly <- c("mpg", "cyl", "disp", "drat", "wt", "qsec", "gear", "carb")

n_vars <- 2
combinations <- combn(predictors, n_vars, simplify = FALSE)
combinations_poly <- combn(predictors_poly, n_vars, simplify = FALSE)

calculate <- function(sign = "+", intercept = FALSE) {

  fit_model_and_calculate_mse <- function(combination) {
    formula_str <- paste(target_var, "~", paste(combination, collapse = sign))
    if (intercept) {
      formula_str <- paste0(formula_str, " - 1")
    }
    formula <- as.formula(formula_str)
    model <- lm(formula, data = data)
    mse <- mean((predict(model, data) - data[[target_var]])^2)
    list(formula = formula_str, mse = mse)
  }

  results <- lapply(combinations, fit_model_and_calculate_mse)

  min_mse_index <- which.min(sapply(results, function(x) x$mse))
  return(min_mse_model <- results[[min_mse_index]])
}

calculate_poly <- function(polynomial_degree = 2) {

  fit_model_and_calculate_mse <- function(combination) {
    poly_terms <- lapply(combination, function(x) paste0("poly(", x, ", ", polynomial_degree, ")"))
    # example: "hp ~ poly(mpg, 2)+poly(cyl, 2)"
    formula_str <- paste(target_var, "~", paste(poly_terms, collapse = "+"))
    formula <- as.formula(formula_str)
    model <- lm(formula, data = data)
    mse <- mean((predict(model, data) - data[[target_var]])^2)
    return(list(formula = formula_str, mse = mse))
  }

  results <- lapply(combinations_poly, fit_model_and_calculate_mse)
  min_mse_index <- which.min(sapply(results, function(x) x$mse))
  return(results[[min_mse_index]])
}

min_mse_model_additive <- calculate("+")
min_mse_model_non_additive <- calculate("*")
min_mse_model_additive_intercept <- calculate("+", TRUE)
min_mse_model_non_additive_intercept <- calculate("*", TRUE)
min_mse_model_poly <- calculate_poly(2)

cat("\nModel with the lowest MSE Additive:\n")
cat(min_mse_model_additive$formula, "MSE:", min_mse_model_additive$mse, "\n")

cat("\nModel with the lowest MSE Non Additive:\n")
cat(min_mse_model_non_additive$formula, "MSE:", min_mse_model_non_additive$mse, "\n")

cat("\nModel with the lowest MSE Additive with Intercept:\n")
cat(min_mse_model_additive_intercept$formula, "MSE:", min_mse_model_additive_intercept$mse, "\n")

cat("\nModel with the lowest MSE Non Additive with Intercept:\n")
cat(min_mse_model_non_additive_intercept$formula, "MSE:", min_mse_model_non_additive_intercept$mse, "\n")

cat("\nModel with the lowest MSE Polynomial:\n")
cat(min_mse_model_poly$formula, "MSE:", min_mse_model_poly$mse, "\n")

# Now finding the model with the lowest value:
mse_values <- c(Additive = min_mse_model_additive$mse,
                Non_Additive = min_mse_model_non_additive$mse,
                Additive_with_Intercept = min_mse_model_additive_intercept$mse,
                Non_Additive_with_Intercept = min_mse_model_non_additive_intercept$mse,
                Polynomial = min_mse_model_poly$mse)

min_mse_model_name <- names(which.min(mse_values))
min_mse_value <- min(mse_values)

cat("\n***********\n Model with the lowest MSE:", min_mse_model_name, "with MSE:", min_mse_value, "\n")

# find the model with the lowest value
#   Model with the lowest MSE: Non_Additive hp ~ cyl*carb with MSE: 373.8966
