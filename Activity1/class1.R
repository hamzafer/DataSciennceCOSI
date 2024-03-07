data <- as.matrix(mtcars)
column_means <- numeric(ncol(data))
column_maxs <- numeric(ncol(data))

# col with loops:
for (i in 1:ncol(data)) {
  column_means[i] <- mean(data[, i])
  column_maxs[i] <- max(data[, i])
}

print(column_means)
cat("\n")
print(column_maxs)

# col without loops:
data <- as.matrix(mtcars)
column_means <- colMeans(data)
column_maxs <- apply(data, 2, max)

print(column_means)
cat("\n")
print(column_maxs)


#row with loops:
data <- as.matrix(mtcars)
row_means <- numeric(nrow(data))
row_maxs <- numeric(nrow(data))

for (i in 1:nrow(data)) {
  row_means[i] <- mean(data[i,])
  row_maxs[i] <- max(data[i,])
}

print(row_means)
cat("\n")
print(row_maxs)

# row without loops:
data <- as.matrix(mtcars)
row_means <- rowMeans(mtcars)
row_maxs <- apply(mtcars, 1, max)

print(row_means)
cat("\n")
print(row_maxs)


# dataset from: "http://datasets.flowingdata.com/birth-rate.csv"
url <- "http://datasets.flowingdata.com/birth-rate.csv"
birth_rate_data <- read.csv(url)

birth_rate_matrix <- as.matrix(birth_rate_data)

column_means <- numeric(ncol(birth_rate_matrix))
column_maxs <- numeric(ncol(birth_rate_matrix))

for (i in 1:ncol(birth_rate_matrix)) {
  # use na.rm = TRUE to remove NA values
  column_means[i] <- mean(birth_rate_matrix[, i], na.rm = TRUE)
  column_maxs[i] <- max(birth_rate_matrix[, i], na.rm = TRUE)
}

column_means
column_maxs
