library(class)
library(MASS)
data(Boston)
set.seed(123)

train <- sample(1:nrow(Boston), nrow(Boston) / 2)
library(nnet)
nn.boston <- nnet(medv ~ ., data = Boston, subset = train, size = 3)
summary(nn.boston)
nn.boston.predict.train <- predict(nn.boston, Boston[train,])
nn.boston.predict.train
nn.boston <- nnet(medv ~ ., data = Boston, subset = train, size = 3, linout = TRUE)

nn.boston <- nnet(medv ~ ., data = Boston, subset = train, size = 8, linout = TRUE)
nn.boston.predict.train <- predict(nn.boston, Boston[train,])
sqrt_train <- sqrt(mean((nn.boston.predict.train - Boston[train, "medv"])^2))

nn.boston.predict.test <- predict(nn.boston, newdata = Boston[-train,])
sqrt_test <- sqrt(mean((nn.boston.predict.test - Boston[-train, "medv"])^2))

# Print mean squared errors
cat("Mean squared error on training set:", sqrt_train, "\n")
cat("Mean squared error on test set:", sqrt_test, "\n")
