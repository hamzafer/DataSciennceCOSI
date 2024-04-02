# Example: iris plants

library(caret)
library(tree)
data(iris)

# Splitting the data into training and testing sets
iris.train <- sample(1:nrow(iris), 100)
iris.test <- iris[-iris.train,]
iris.test.Species <- iris.test[, "Species"]

# Creating the decision tree model
iris.tree <- tree(Species ~ ., iris, subset = iris.train)

# Predicting Species for the test set
tree.pred <- predict(iris.tree, iris.test, type = "class")

# Confusion Matrix for the predictions
table(tree.pred, iris.test.Species)

# For more detailed performance metrics
confusionMatrix(tree.pred, iris.test.Species)
