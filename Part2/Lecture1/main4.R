# Example: iris plants

library(rpart)
library(rattle)
data(iris)

iris.tree <- rpart(Species ~ ., iris, subset=iris.train)
tree.pred <- predict(iris.tree, iris.test, type="class")
fancyRpartPlot(iris.tree)
