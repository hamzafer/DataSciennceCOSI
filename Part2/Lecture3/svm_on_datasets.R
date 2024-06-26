# SVC with linear kernel
# its support vector classifier and not support vector machine
# kernel="linear"

library(caret)
library(e1071)
library(MASS)
library(ggplot2)
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

# Plotting the decision boundary
# Extracting the support vectors
support_vectors <- breast_cancer[bestmod$index, -1]

# Extracting the coefficients of the linear SVM model
coefficients <- bestmod$coefs
intercept <- bestmod$rho

# Define a function to calculate the decision boundary
decision_boundary <- function(x) {
  -(coefficients[1] * x + intercept) / coefficients[2]
}

# Plotting the data points
ggplot(data = breast_cancer, aes(x = radius_mean, y = texture_mean, color = diagnosis)) +
  geom_point() +
  geom_abline(slope = -coefficients[1] / coefficients[2], intercept = -intercept / coefficients[2], linetype = "dashed") +
  xlim(range(breast_cancer$radius_mean)) +
  ylim(range(breast_cancer$texture_mean)) +
  labs(title = "SVM Decision Boundary",
       x = "Radius Mean",
       y = "Texture Mean")
