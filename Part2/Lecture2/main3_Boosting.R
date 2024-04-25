# Example: breast_cancer plants

library(caret)
library(tree)
library(randomForest)
load("breast_cancer.RData")
set.seed(2)
library(gbm)

breast_cancer$diagnosis <- as.factor(breast_cancer$diagnosis)

train <- sample(1:nrow(breast_cancer), nrow(breast_cancer) / 2)
breast_cancer.test <- breast_cancer[-train, "diagnosis"]

breast_cancer.tree <- gbm(diagnosis ~ ., data = breast_cancer[train,], distribution = "gaussian", n.trees = 5000, interaction.depth = 4)
yhat.boost <- predict(breast_cancer.tree, newdata = breast_cancer[-train,], n.trees = 5000)
mean((yhat.boost - breast_cancer.test)^2)
summary(breast_cancer.tree)

# Confusion Matrix for the predictions
table(yhat.boost, breast_cancer.test)

# For more detailed performance metrics
confusionMatrix(yhat.boost, breast_cancer.test)
accuracy <- confusionMatrix(yhat.boost, breast_cancer.test)$overall["Accuracy"]
accuracy
