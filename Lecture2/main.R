# Additive Linear Regression
model <- lm(hp ~ cyl + carb + qsec, mtcars)
summary(model)

# Non Additive Linear Regression
model1 <- lm(hp ~ cyl * carb, mtcars)
summary(model1)

# Polynomial Regression
model2 <- lm(mpg ~ hp + I(hp^2), mtcars)
summary(model2)
plot(model2)
