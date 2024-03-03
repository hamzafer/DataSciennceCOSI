library(datasets)
data("mtcars")
set.seed(123)

# Original model
original_model <- lm(hp ~ disp + carb, data = mtcars)
original_coefficients <- coef(original_model)

n_bootstrap <- 1000

# Custom Bootstrap function
# here i am simply gonna take an array same as the size of the original mode
# and then im gonna repeat some rows and ommit some rows for resampling
# then simply applying the same model to the new data and calculate coeff
custom_bootstrap <- function(data, n_bootstrap) {
  bootstrap_estimates <- matrix(NA, nrow = n_bootstrap, ncol = length(original_coefficients))

  for (i in 1:n_bootstrap) {
    bootstrap_sample <- data[sample(nrow(data), replace = TRUE), ]
    bootstrap_model <- lm(hp ~ disp + carb, data = bootstrap_sample)
    bootstrap_estimates[i, ] <- coef(bootstrap_model)
  }

  colnames(bootstrap_estimates) <- names(original_coefficients)
  return(bootstrap_estimates)
}

bootstrap_results <- custom_bootstrap(mtcars, n_bootstrap)
bootstrap_se <- apply(bootstrap_results, 2, sd)

summary(bootstrap_se)
print(bootstrap_se)
# print(lm(hp~disp+carb,data=mtcars))
# summary(lm(hp~disp+carb,data=mtcars))

# comparison attached in the txt file.