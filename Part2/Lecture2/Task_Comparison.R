# Comparing different models on the same dataset

# Forrest
# Random Forest : mtry and ntree parameters
# Boosting
# Bagging
# Gradient Boosting
# XGBoost

library(randomForest)
library(MASS)
set.seed(1)
data(Boston)
train <- sample(1:nrow(Boston), nrow(Boston)/2)
boston.test <- Boston[-train, "medv"]

bag.boston <- randomForest(medv~., data=Boston, subset=train, mtry=13, importance=TRUE)

yhat.bag <- predict(bag.boston, newdata=Boston[-train,])
plot(yhat.bag, boston.test)
abline(0,1)
mean((yhat.bag - boston.test)^2)

bag.boston <- randomForest(medv~., data=Boston, subset=train, mtry=13, ntree=25)
