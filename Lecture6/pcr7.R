# Load pls package
library(pls)

# Set seed for reproducibility
set.seed(2)

# Randomly split the data into training and test sets
train <- sample(1:nrow(mtcars), nrow(mtcars) / 2)
test <- (-train)

# Fit the PCR model
pcr.fit <- pcr(hp ~ ., data = mtcars, subset = train, scale = TRUE, validation = "CV")

# Summarize the PCR fit
summary(pcr.fit)

# Plot the validation plot
validationplot(pcr.fit, val.type = "MSEP")

# Predict on test set and calculate mean squared prediction error for 2 components
prediction <- predict(pcr.fit, mtcars[test,], comp = 2)
mean((prediction - mtcars[test,]$hp)^2)

# Predict on test set and calculate mean squared prediction error for 7 components
prediction <- predict(pcr.fit, mtcars[test,], comp = 7)
mean((prediction - mtcars[test,]$hp)^2)

# Refit the PCR model with 2 components
pcr.fit <- pcr(hp ~ ., data = mtcars, scale = TRUE, ncomp = 2)
