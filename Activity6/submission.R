library(MASS)
library(ISLR)
library(ROCR)
library(class)
library(DMwR2)
data("Default")

set.seed(2)
Default2 <- na.omit(Default)
# Make "No" the positive default
Default2$default <- factor(Default2$default, c("No", "Yes"))

# Each of nine attributes has been scored on a scale of 1 to 10
# Just in case
names <- names(Default2)
scaled <- data.frame(Default2[, 1:2], scale(Default2[, 3:4]))
Default2 <- scaled
names(Default2) <- names

train <- sample(nrow(Default2), nrow(Default2) / 2, replace = FALSE)
train.set <- Default2[train,]
test.set <- Default2[-train,]

##

# Prior probabilities for each default.
total <- sum(table(Default2$default))
prior.prob <- c(table(Default2$default)[1] / total, table(Default2$default)[2] / total)

###
train.set$default <- as.factor(train.set$default == "No")
test.set$default <- as.factor(test.set$default == "No")

k1 <- 5
k2 <- 10

knn.pred1 <- knn(train = train.set[, -1], test = test.set[, -1], cl = train.set[, 1], k = k1)
knn.pred2 <- knn(train = train.set[, -1], test = test.set[, -1], cl = train.set[, 1], k = k2)

####

# Get probabilities of positive default
adapted.pred1 <- knn.pred1$posterior[, 1] # Probability of positive default
adapted.pred2 <- knn.pred2$posterior[, 1] # Probability of positive default
# ROCR requirement lowest level -> negative default
adapted.labels <- ifelse(test.set$default == "No", 1, 0)

###

assessModel <- function(adapted.pred, adapted.labels)
{
  pred <- prediction(adapted.pred, adapted.labels)
  plot(performance(pred, 'tpr', 'fpr'))
  # print(performance(pred, 'tpr', 'fpr'))
  auc <- performance(pred, measure = "auc")
  print(attr(auc, "y.values")[[1]])
  # TPR, FPR and cutoff values
  # print(performance(pred, measure = "tpr")@y.values[[1]])
  # print(performance(pred, measure = "fpr")@y.values[[1]])
  # print(performance(pred, 'tpr', 'fpr')@alpha.values[[1]])
  print("______________")
}

assessModel(adapted.pred1, adapted.labels)
assessModel(adapted.pred2, adapted.labels)
