## Linear Regression

model <- lm(hp ~ cyl + carb + qsec, mtcars)
summary(model)

# Non additive linear regression
model1 <- lm(hp ~ cyl * carb, mtcars)
summary(model1)
