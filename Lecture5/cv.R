library(leaps)
set.seed(2)
k <- 10
data.rows <- nrow(mtcars)
data.cols <- ncol(mtcars)
nSets <- data.cols - 1

shuffled <- mtcars[sample(data.rows),]

# Create 10 equally sized folds
folds <- cut(seq(1, data.rows), breaks = k, labels = FALSE)
cv.errors <- matrix(NA, k, nSets)

make.prediction <- function(object, testData, nPredictors) {
  form <- as.formula(object$call[[2]]) # Get the formula
  mat <- model.matrix(form, testData)
  coefi <- coef(object, id = nPredictors)
  vars <- names(coefi)
  mat[, vars] %*% coefi
}

for (i in 1:k) {
  testIndexes <- which(folds == i, arr.ind = TRUE)
  testData <- shuffled[testIndexes,]
  trainData <- shuffled[-testIndexes,]

  # Best subsets using fold i
  best.fit <- regsubsets(hp ~ ., data = trainData, nvmax = nSets)

  for (j in 1:nSets) {
    prediction <- make.prediction(best.fit, testData, j)
    cv.errors[i, j] <- mean((testData$hp - prediction)^2)
  }
}

cv.errors.mean <- apply(cv.errors, 2, mean)
which.min(cv.errors.mean)
# [1] 3
