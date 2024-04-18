library(class)
data(iris)
set.seed(123)

train <- sample(1:nrow(iris), nrow(iris) / 2)
library(nnet)
nn.iris <- nnet(Species ~ ., data = iris, subset = train, size = 3)
summary(nn.iris)
nn.iris.predict.train <- predict(nn.iris, iris[train,], type = "class")
nn.iris.predict.train <- as.factor(nn.iris.predict.train)
table(nn.iris.predict.train, iris[train, "Species"])
confusion.train <- table(nn.iris.predict.train, iris[train, "Species"])
accuracy.train <- sum(diag(confusion.train)) / sum(confusion.train)

nn.iris.predict.test <- predict(nn.iris, iris[-train,], type = "class")
nn.iris.predict.test <- as.factor(nn.iris.predict.test)
table(nn.iris.predict.test, iris[-train, "Species"])
confusion.test <- table(nn.iris.predict.test, iris[-train, "Species"])
accuracy.test <- sum(diag(confusion.test)) / sum(confusion.test)

# Print accuracies
cat("Accuracy on training set:", accuracy.train, "\n")
cat("Accuracy on test set:", accuracy.test, "\n")

