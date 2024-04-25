# R script for topic 8: Trees

# page 8
library(class)
library(ISLR)
library(tree)
load("kchousing.RData")

tree.model <- tree(price ~ ., data = kchousing)
# Simplify the tree by pruning, best=number of nodes
smodel <- prune.tree(tree.model, best = 3)
plot(smodel)
text(smodel)
smodel
model <- tree(price ~ ., data = kchousing)

# page 10
data(iris)
iris.tree <- tree(Species ~ ., iris)
plot(iris.tree)
text(iris.tree)
iris.tree

# page 11
library(caret)

iris.train <- sample(1:nrow(iris), 100)
iris.test <- iris[-iris.train,]
iris.test.Species <- iris.test[, "Species"]

iris.tree <- tree(Species ~ ., iris, subset = iris.train)
tree.pred <- predict(iris.tree, iris.test, type = "class")
table(tree.pred, iris.test.Species)
# For more detailed performance metrics
confusionMatrix(tree.pred, iris.test.Species)

# page 12
library(rpart)
library(rattle)
iris.tree <- rpart(Species ~ ., iris, subset = iris.train)
tree.pred <- predict(iris.tree, iris.test, type = "class")
fancyRpartPlot(iris.tree)

# page 13
library(class)
library(ISLR)
data(Carseats)
attach(Carseats)
library(tree)
High <- ifelse(Sales <= 8, "No", "Yes")
High <- factor(High)
Carseats <- data.frame(Carseats, High)
tree.carseats <- tree(High ~ . - Sales, Carseats)

# page 14
set.seed(2)
train <- sample(1:nrow(Carseats), 200)
Carseats.test <- Carseats[-train,]
High.test <- High[-train]

tree.carseats <- tree(High ~ . - Sales, Carseats, subset = train)
tree.pred <- predict(tree.carseats, Carseats.test, type = "class")
table(tree.pred, High.test)


# page 15
set.seed(3)
cv.carseats <- cv.tree(tree.carseats, FUN = prune.misclass)
names(cv.carseats)

prune.carseats <- prune.misclass(tree.carseats, best = 9)


# page 20

library(randomForest)
library(MASS)
set.seed(1)
data(Boston)
train = sample(1:nrow(Boston), nrow(Boston) / 2)
boston.test <- Boston[-train, "medv"]

bag.boston <- randomForest(medv ~ ., data = Boston, subset = train, mtry = 13, importance = TRUE)
bag.boston

yhat.bag <- predict(bag.boston, newdata = Boston[-train,])
plot(yhat.bag, boston.test)
abline(0, 1)
mean((yhat.bag - boston.test)^2)

bag.boston <- randomForest(medv ~ ., data = Boston, subset = train, mtry = 13, ntree = 25)

# page 22

library(randomForest)
set.seed(1)
data(Boston)
train = sample(1:nrow(Boston), nrow(Boston) / 2)
boston.test <- Boston[-train, "medv"]

rf.boston <- randomForest(medv ~ ., data = Boston, subset = train, mtry = 6, importance = TRUE)
yhat.rf <- predict(rf.boston, newdata = Boston[-train,])
mean((yhat.rf - boston.test)^2)

importance(rf.boston)
varImpPlot(rf.boston)

# page 24

library(gbm)
set.seed(1)
data(Boston)
boost.boston <- gbm(medv ~ ., data = Boston[train,], distribution = "gaussian", n.trees = 5000, interaction.depth = 4)
summary(boost.boston)

yhat.boost <- predict(boost.boston, newdata = Boston[-train,], n.trees = 5000)
mean((yhat.boost - boston.test)^2)

boost.boston <- gbm(medv ~ ., data = Boston[train,], distribution = "gaussian", n.trees = 5000, interaction.depth = 4, shrinkage = 0.2, verbose = F)
yhat.boost <- predict(boost.boston, newdata = Boston[-train,], n.trees = 5000)
mean((yhat.boost - boston.test)^2)
summary(boost.boston)

# page 25

boost.boston <- gbm(medv ~ ., data = Boston[train,],
                    distribution = "gaussian", n.trees = 5000, interaction.depth = 4,
                    shrinkage = 0.2, verbose = F)
yhat.boost <- predict(boost.boston, newdata = Boston[-train,],
                      n.trees = 5000)
mean((yhat.boost - boston.test)^2)
summary(boost.boston)

