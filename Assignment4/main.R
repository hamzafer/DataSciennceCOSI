library(datasets)
data(mtcars)
set.seed(2)

k <- 10
rows <- nrow(mtcars)

# Shuffle the dataset
shuffled <- mtcars[sample(rows),]

# Create 10 equally sized folds
folds <- cut(seq(1, rows), breaks = k, labels = FALSE)

# Lists to hold the train and test sets
train_sets <- list()
test_sets <- list()

for (i in 1:k) {
  testIndexes <- which(folds == i)
  testData <- shuffled[testIndexes,]
  trainData <- shuffled[-testIndexes,]

  test_sets[[i]] <- testData
  train_sets[[i]] <- trainData
}

# The train_sets and test_sets lists now contain the training and test sets for each fold
# Example for the first fold:
cat("Fold #1:\n")
cat("Total Count: ", nrow(train_sets[[1]]) + nrow(test_sets[[1]]), "\n")

cat("Training Set Data:\n")
print(train_sets[[1]])
cat("Training Set Count:\n")
print(nrow(train_sets[[1]]))

cat("Test Set Data:\n")
print(test_sets[[1]])
cat("Test Set Count:\n")
print(nrow(test_sets[[1]]))
