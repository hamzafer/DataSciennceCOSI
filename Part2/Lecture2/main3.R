# Example: breast_cancer plants

library(caret)
library(tree)
library(rpart)
library(rattle)
load("breast_cancer.RData")
set.seed(2)

breast_cancer$diagnosis <- as.factor(breast_cancer$diagnosis)

# Splitting the data into training and testing sets
breast_cancer.train <- sample(1:nrow(breast_cancer), 100)
breast_cancer.test <- breast_cancer[-breast_cancer.train,]
breast_cancer.test.diagnosis <- breast_cancer.test[, "diagnosis"]

# Creating the decision tree model
breast_cancer.tree <- tree(diagnosis ~ ., breast_cancer, subset = breast_cancer.train)

breast_cancer.treeFancy <- rpart(diagnosis ~ ., breast_cancer, subset = breast_cancer.train)

# Predicting diagnosis for the test set
tree.pred <- predict(breast_cancer.tree, breast_cancer.test, type = "class")

# Confusion Matrix for the predictions
table(tree.pred, breast_cancer.test.diagnosis)

# For more detailed performance metrics
confusionMatrix(tree.pred, breast_cancer.test.diagnosis)
fancyRpartPlot(breast_cancer.treeFancy)

# Accuracy : 0.9275