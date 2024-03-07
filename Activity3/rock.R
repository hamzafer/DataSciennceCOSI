# 2.- Create a linear regression model using the rock dataset. The response variable is: area

data <- rock
area_index <- colnames(data[1])

for (i in 1:ncol(data)) {
  if (i == 1) {
    next
  }
  pastevalue <- paste(area_index, colnames(data)[i], sep = "~")
  expression <- as.formula(pastevalue)
  model <- lm(expression, data)
  summary(model)
  cat("Mean Squared Error of hp with", colnames(data)[i], ":\n")
  print(mean((predict(model) - data$area)^2))
}

# I will not go with the model with single variable because all has very high MSE

# Now checking with multiple variables
model <- lm(area ~ peri, data)
model2 <- lm(area ~ peri + shape + perm, data) # Additive Linear Regression
model3 <- lm(area ~ peri * shape * perm, data) # Non Additive Linear Regression
model4 <- lm(area ~ peri + I(peri^2), data) # Polynomial Regression
model5 <- lm(area ~ ., data)
model6 <- lm(area ~ peri  + I(peri^2) + shape + I(shape^2)+ perm+ I(perm^2), data)
model7 <- lm(area ~ peri  + I(peri^2) + shape + I(shape^2)+ perm+ I(perm^2) + I(peri^3) + I(shape^3) + I(perm^3), data)

cat("Mean Squared Error one variable", mean((predict(model) - data$area)^2), "\n")
cat("Mean Squared Error two variables", mean((predict(model2) - data$area)^2), "\n")
cat("Mean Squared Error three variables", mean((predict(model3) - data$area)^2), "\n")
cat("Mean Squared Error four variables", mean((predict(model4) - data$area)^2), "\n")
cat("Mean Squared Error all variables", mean((predict(model5) - data$area)^2), "\n")
cat("Mean Squared Error all variables but polynomial", mean((predict(model6) - data$area)^2), "\n")
cat("Mean Squared Error all variables but polynomial", mean((predict(model7) - data$area)^2), "\n")

# I am choosing the model7 with polynomial having two degrees because it has the lowest MSE (1071161)

# summary(model)
# plot(model)
