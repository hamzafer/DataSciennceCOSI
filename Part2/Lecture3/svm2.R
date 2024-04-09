# SVC with linear kernel
# its support vector classifier and not support vector machine
# kernel="linear"

library(caret)
library(e1071)
library(MASS)
data(Pima.tr)
data(Pima.te)

set.seed(1)

svmfit <- svm(type ~ ., data=Pima.tr, kernel="linear", cost=10, scale=FALSE)

svmfit.predict <- predict(svmfit, Pima.te, type="class")
table(svmfit.predict, truth=Pima.te$type)
mean(svmfit.predict == Pima.te$type)
confusionMatrix(data = svmfit.predict, reference = Pima.te$type)
