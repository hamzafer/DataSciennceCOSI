# Topc: Selecting models and predictors

summary(lm(hp ~ mpg + 1, mtcars))
library(leaps)
regfit.full <- regsubsets(hp ~ ., data = mtcars, nvmax = 10)
summary(regfit.full)

# Adding polynomial terms
regfit.full <- regsubsets(hp ~ . + I(cyl^2), data = mtcars, nvmax = 10)
sum_obj <- summary(regfit.full)

sum_obj$bic
sum_obj$cp