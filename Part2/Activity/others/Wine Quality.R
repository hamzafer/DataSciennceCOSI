#Regression on wine quality. Preprocess the data. Random forest, decision trees, SVM, NN

#data <- read.csv("C:/Users/Dipayan/Downloads/wine+quality/winequality-white.csv", sep = ";") #White wine
data <- read.csv("C:/Users/Dipayan/Downloads/wine+quality/winequality-red.csv", sep = ";") #Red wine

#imbalance usually used for classification

summary(data)

scaled_data <- scale(data)
data_frame <- as.data.frame(scaled_data)

missing_values <- any(is.na(data_frame))

library(e1071)
library(caret)
set.seed(12)
train_idx <- sample(1:nrow(data_frame),0.5*nrow(data_frame))
training_data <- data_frame[train_idx, ]
testing_data <- data_frame[-train_idx, ]

svm_model <- svm(alcohol ~ ., data = training_data, kernel ="radial", gamma=3, cost=1)
predictions <- predict(svm_model, newdata = testing_data)

mse <- mean((testing_data$alcohol - predictions)^2)
print(paste("Mean Squared Error (MSE):", mse))

mrae <- mean(abs((testing_data$alcohol - predictions) / testing_data$alcohol))
print(paste("MRAE:", mrae))
