# SVC with linear kernel
# its support vector classifier and not support vector machine
# kernel="linear"

library(caret)
library(e1071)
library(MASS)
load("breast_cancer.RData")
set.seed(1)

breast_cancer$diagnosis <- as.factor(breast_cancer$diagnosis)

svmfit <- tune(svm, diagnosis ~ ., data = breast_cancer, kernel = "linear", type = "C-classification",
               ranges = list(cost = c(0.001, 0.01, 0.1, 1, 5, 10, 100)))
summary(svmfit)
bestmod <- svmfit$best.model

svmfit.predict <- predict(bestmod, breast_cancer, type = "class")
table(svmfit.predict, truth = breast_cancer$diagnosis)
mean(svmfit.predict == breast_cancer$diagnosis)
confusionMatrix(data = svmfit.predict, reference = breast_cancer$diagnosis)

accuracy_percentage <- mean(svmfit.predict == breast_cancer$diagnosis) * 100
print(paste("Accuracy:", accuracy_percentage, "%"))

# Increase in accuracy!
