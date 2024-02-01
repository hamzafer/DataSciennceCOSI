# 3.- Create a linear regression model using the pressure dataset. The response variable is: pressure

# I was done early with the activity so I am optimizing the code
# I am gonna make the polynomial degree dynamic

data <- pressure
model <- lm(pressure ~ temperature, data) # Linear Regression
model5 <- lm(pressure ~ ., data) # Linear Regression with all variables

# Polynomial Regression with different degrees
polynomial_degree <- 4
for (i in polynomial_degree) {
  pastevalue <- paste("pressure ~ temperature", sep = "~")
  for (j in 2:i) {
    pastevalue <- paste0(pastevalue, "+ I(temperature^", j, ")")
    expression <- as.formula(pastevalue)
    polynomial_model <- lm(expression, data)
    summary(polynomial_model)
    cat("Mean Squared Error of temperature with", i, "degree polynomial:\n")
    print(mean((predict(polynomial_model) - data$pressure)^2))
    min_mse <- min(mean((predict(polynomial_model) - data$pressure)^2))
    min_mse_degree <- i
  }
}

cat("Minimum MSE is", min_mse, "\n")
cat("Minimum MSE Degree is", min_mse_degree, "\n")

# I am choosing the model4 with polynomial having four degrees because it has the lowest MSE (21.32641)

# summary(model)
# plot(model4)
