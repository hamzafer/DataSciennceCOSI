library(class)
iris.length <- iris[, c('Sepal.Length', 'Petal.Length', 'Species')]
train <- iris.length[, c(1, 2)]
cl <- iris.length[, 'Species']

x1 <- seq(min(range(iris.length$Sepal.Length)), max(range(iris.length$Sepal.Length)), by = 0.1)
x2 <- seq(min(range(iris.length$Petal.Length)), max(range(iris.length$Petal.Length)), by = 0.1)
grid <- expand.grid(x1, x2)
test <- data.frame(Sepal.Length = grid[, 1], Petal.Length = grid[, 2])

model15 <- knn(train, test, cl, k = 15, prob = TRUE)
result <- matrix(as.numeric(model15), length(x1), length(x2))

# Plot the contour map
contour(x1, x2, result, levels = c(1.5, 2.5))
# Add points for the test set
points(test, pch = ".", col = ifelse(model15 == 'setosa', "red", ifelse(model15 == 'versicolor', "blue", "green")))
# Add points for the training set
points(train, col = ifelse(cl == 'setosa', "red", ifelse(cl == 'versicolor', "blue", "green")))
