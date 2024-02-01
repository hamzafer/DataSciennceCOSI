# 1.- Create a linear regression model using the women dataset. The response variable is: weight

data <- women
model <- lm(weight ~ height, data)
model2 <- lm(weight ~ height + I(height^2), data) # Polynomial Regression
model3 <- lm(weight ~ height + I(height^2) + I(height^3), data)
model4 <- lm(weight ~ height + I(height^2) + I(height^3) + I(height^4), data)
model5 <- lm(weight ~ ., data)

cat("Mean Squared Error one variable", mean((predict(model) - data$weight)^2), "\n")
cat("Mean Squared Error Polynomial Regression 2 degree", mean((predict(model2) - data$weight)^2), "\n")
cat("Mean Squared Error Polynomial Regression 3 degree", mean((predict(model3) - data$weight)^2), "\n")
cat("Mean Squared Error Polynomial Regression 4 degree", mean((predict(model4) - data$weight)^2), "\n")
cat("Mean Squared Error all variables", mean((predict(model5) - data$weight)^2), "\n")

# I am choosing the model4 with polynomial having four degrees because it has the lowest MSE (0.03357325)

# summary(model)
# plot(model)
