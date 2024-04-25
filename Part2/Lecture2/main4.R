# Example: breast_cancer plants

library(rpart)
library(rattle)
load("breast_cancer.RData")

# Splitting the data into training and testing sets
breast_cancer.train <- sample(1:nrow(breast_cancer), 100)
breast_cancer.test <- breast_cancer[-breast_cancer.train,]
breast_cancer.test.Species <- breast_cancer.test[, "diagnosis"]

breast_cancer.tree <- rpart(diagnosis ~ ., breast_cancer, subset = breast_cancer.train)
tree.pred <- predict(breast_cancer.tree, breast_cancer.test, type = "class")
table(tree.pred, breast_cancer.test.diagnosis)

fancyRpartPlot(breast_cancer.tree)
