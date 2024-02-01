# Create all the possible linear models with one variable to predict the hp value using the mtcars data-set.
# Show the mean squared train error of each model

data <- mtcars
hp_index <- colnames(data[4])

for (i in 1:ncol(data)) {
  if (i == 4) {
    next
  }
  pastevalue <- paste(hp_index, colnames(data)[i], sep = "~")
  expression <- as.formula(pastevalue)
  model <- lm(expression, data)
  summary(model)
  cat("Mean Squared Error of hp with", colnames(data)[i], ":\n")
  print(mean((predict(model) - data$hp)^2))
}
