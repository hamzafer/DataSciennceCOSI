# Find the best linear regression model for estimating the mpg value in the mtcars dataset using up to 7 variables.
# Use the Bayesian Information Criterion to rank models with different number of predictors.
library(leaps)
regfit.full <- regsubsets(mpg ~ ., data = mtcars, nvmax = 7)
summary(regfit.full)
sum_obj <- summary(regfit.full)

sum_obj$bic
which(sum_obj$bic == min(sum_obj$bic))
# [1] 3
# The best model has 3 predictors.
# Which are: 3
# cyl disp hp  drat wt  qsec vs  am  gear carb
# " " " "  " " " "  "*" "*"  " " "*" " "  " "

# Obtaining the coefficients of the best model
coef(regfit.full, 3)
#(Intercept)          wt        qsec          am
# 9.617781   -3.916504    1.225886    2.935837
