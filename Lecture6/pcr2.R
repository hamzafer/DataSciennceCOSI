# Load pls package
library(pls)

# Set seed for reproducibility
set.seed(2)

# Randomly split the data into training and test sets
train <- sample(1:nrow(mtcars), nrow(mtcars)/2)
test <- (-train)

# Fit the PLS model
plsr.fit <- plsr(hp ~ ., data=mtcars, subset=train, scale=TRUE, validation="CV")

# Summarize the PLS fit
summary(plsr.fit)

# Plot the validation plot
validationplot(plsr.fit, val.type="MSEP")

# Predict on test set and calculate mean squared prediction error for 2 components
prediction <- predict(plsr.fit, mtcars[test,], comp=2)
mean((prediction - mtcars[test,]$hp)^2)

# Refit the PLS model with 2 components
plsr.fit <- plsr(hp ~ ., data=mtcars, scale=TRUE, ncomp=2)
