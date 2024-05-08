# Code example for Topic 9: Support Vector Machines

# page 19
# frame: Artificial dataset SVC
library(e1071)
set.seed(1)
# Create random dataset
x <- matrix(rnorm(20 * 2), ncol = 2)
y <- c(rep(-1, 10), rep(1, 10))
x[y == 1,] <- x[y == 1,] + 1
# Check whether the classes are linearly separable
plot(x, col = (3 - y))
# Create data.frame with factor class attribute
dat <- data.frame(x = x, y = as.factor(y))
svmfit <- svm(y ~ ., data = dat, kernel = "linear", cost = 10, scale = FALSE)
plot(svmfit, dat)
svmfit$index
summary(svmfit)

# page 20
# frame: Artificial dataset SVC: tuning
# Check C = 0.1
svmfit <- svm(y ~ ., data = dat, kernel = "linear", cost = 0.1, scale = FALSE)
plot(svmfit, dat)
svm$index

# e1071 automatic tuning
tune.out <- tune(svm, y ~ ., data = dat, kernel = "linear", ranges = list(cost = c(0.001, 0.01, 0.1, 1, 5, 10, 100)))

bestmod <- tune.out$best.model

summary(bestmod)

# page 21
# frame: Artificial dataset SVC: evaluate
# Evaluate on test set
xtest <- matrix(rnorm(20 * 2), ncol = 2)
ytest <- sample(c(-1, 1), 20, rep = TRUE)
xtest[ytest == 1,] <- xtest[ytest == 1,] + 1
testdat <- data.frame(x = xtest, y = as.factor(ytest))

# Predictions with the best model
ypred <- predict(bestmod, testdat)
table(predict = ypred, truth = testdat$y)

# page 22
# frame: Pima SVC
ibrary(e1071)
library(MASS)
data(Pima.tr)
data(Pima.te)

set.seed(1)

svmfit <- svm(type ~ ., data = Pima.tr, kernel = "linear", cost = 10, scale = FALSE)

svmfit.predict <- predict(svmfit, Pima.te, type = "class")
table(svmfit.predict, truth = Pima.te$type)
mean(svmfit.predict == Pima.te$type)

# page 30
# frame: SVM with radial kernel
library(e1071)

set.seed(1)
x <- matrix(rnorm(200 * 2), ncol = 2)
x[1:100,] <- x[1:100,] + 2
x[101:150,] <- x[101:150,] - 2
y <- c(rep(1, 150), rep(2, 50))
dat <- data.frame(x = x, y = as.factor(y))

plot(x, col = y)

train <- sample(200, 100)
svmfit <- svm(y ~ ., data = dat[train,], kernel = "radial", gamma = 1, cost = 1)
plot(svmfit, dat[train,])

summary(svmfit)

svmfit <- svm(y ~ ., data = dat[train,], kernel = "radial", gamma = 1, cost = 1e5)
plot(svmfit, dat[train,])

# page 31
# frame: SVM with radial kernel auto-tuning
set.seed(1)
tune.out <- tune(svm, y ~ ., data = dat[train,], kernel = "radial", ranges = list(cost = c(0.1, 1, 10, 100, 1000), gamma = c(0.5, 1, 2, 3, 4)))
summary(tune.out)

table(true = dat[-train, "y"], pred = predict(tune.out$best.model, newdata = dat[-train,]))

# page 32
# frame: SVM with Multiple Classes

set.seed(1)
x <- rbind(x, matrix(rnorm(50 * 2), ncol = 2))
y <- c(y, rep(0, 50))
x[y == 0, 2] <- x[y == 0, 2] + 2
dat <- data.frame(x = x, y = as.factor(y))
par(mfrow = c(1, 1))
plot(x, col = (y + 1))

svmfit <- svm(y ~ ., data = dat, kernel = "radial", cost = 10, gamma = 1)

plot(svmfit, dat)


# page 33
data(iris)
svmi <- svm(Species ~ ., data = iris, kernel = "linear", cost = 10)
svmi.predict <- predict(svm, data = iris, type = "class")
table(svmi.predict, iris$Species)

svmi <- svm(Species ~ ., data = iris, kernel = "radial", cost = 10)
svmi.predict <- predict(svm, data = iris, type = "class")
table(svmi.predict, iris$Species)

# page 35
# frame: Support Vector Regression
data(Boston)
train <- sample(1:nrow(Boston), nrow(Boston) / 2)
svmfit <- svm(medv ~ ., data = Boston[train,], kernel = "linear", cost = 10)
summary(svmfit)
svmfit.predict <- predict(svmfit, newdata = Boston[-train,])
sqrt(mean((Boston[-train, "medv"] - svmfit.predict)^2))




