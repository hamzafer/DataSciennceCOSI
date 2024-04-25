data(iris)
library(psych)

# Create a vector of indices for the training set
train_indices <- sample(1:nrow(iris), 100)
# Create the training set
iris.train <- iris[train_indices,]
# Create the test set by removing the rows in `iris` that are in the training set
iris.test <- iris[-train_indices,]

pairs.panels(iris.train[, -5], gap = 0,
             bg = c("red", "yellow", "blue")[iris.train$Species],
             pch = 21)

pc <- prcomp(iris.train[, -5], center = TRUE, scale = TRUE)
print(pc)

trg <- predict(pc, iris.train)
trg <- data.frame(trg, iris.train[5])
tst <- predict(pc, iris.test)
tst <- data.frame(tst, iris.test[5])
