library(MASS)
data(fgl)

myROS <- function(dataset, size) {
  new_samples <- vector()

  if (nrow(dataset) < size) {
    new_samples <- sample(nrow(dataset), size - nrow(dataset), replace = TRUE)
  }

  new_dataset <- rbind(dataset, dataset[new_samples,])

  return(new_dataset)
}

mySelectClasses <- function(dataset, class1, class2, response) {
  col <- which(colnames(dataset) == response)
  samples.class1 <- dataset[dataset[, col] == class1,]
  samples.class2 <- dataset[dataset[, col] == class2,]

  if (nrow(samples.class1) > nrow(samples.class2)) {
    majority <- samples.class1
    minority <- samples.class2
  } else {
    majority <- samples.class2
    minority <- samples.class1
  }

  minority <- myROS(minority, nrow(majority))
  result <- rbind(majority, minority)

  # Restrict the levels
  result[, col] <- factor(result[, col], levels = c(class1, class2))

  return(result)
}

set.seed(2)
dataset <- fgl
train <- sample(nrow(dataset), nrow(dataset) / 2)
train.set <- dataset[train,]
test.set <- dataset[-train,]
response <- "type"
formula <- as.formula(paste(response, "~ .", sep = ""))

col <- which(colnames(dataset) == response)
k <- length(levels(dataset[, col]))

predictions <- rep(dataset[1, col], nrow(test.set) * k * (k - 1) / 2)
dim(predictions) <- c(nrow(test.set), k * (k - 1) / 2)

ovo.model <- 1

for (i in 1:(k - 1)) {
  for (j in (i + 1):k) {
    class1 <- levels(train.set[, col])[i]
    class2 <- levels(train.set[, col])[j]

    local.train.dataset <- mySelectClasses(train.set, class1, class2, response)

    model <- lda(formula, data = local.train.dataset)
    predictions[, ovo.model] <- predict(model, test.set)$class
    ovo.model <- ovo.model + 1
  }
}

result <- rep(dataset[1, col], nrow(test.set))

# Get majority vote
for (i in 1:nrow(test.set)) {
  result[i] <- names(sort(table(predictions[i,]), decreasing = TRUE))[1]
}

t <- table(result, test.set[, col])
print(t)

accuracy <- sum(diag(t)) / sum(t)
print(paste("Accuracy:", accuracy))

