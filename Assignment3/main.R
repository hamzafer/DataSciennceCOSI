# Old code

# Using the fgl dataset (MASS package), create an OVO classifier using LDA based binary classifiers.
library(MASS)
data(fgl)
# print(head(fgl))

# Calculate total number of classes
classes <- unique(fgl$type)
totalClasses <- nrow(table(classes))
# For the OVO strategy, we will create a binary classifier for each pair of classes.
# With 6 classes in this case, we have C(6, 2) = 6 * (6-1) / 2 = 15 binary classifiers.
# For each unique pair of classes (i, j), where i ≠ j and i, j ∈ {1 ... K}
# we create a binary classifier that distinguishes class i from class j.

# Prepare the data
fgl_data <- fgl[, -c(8, ncol(fgl))]  # Features
fgl_classes <- fgl[, ncol(fgl)]  # Class labels

# Generate all pairs of classes
class_pairs <- combn(unique(fgl_classes), 2, simplify = FALSE)

train_lda_pair <- function(pair, data, classes) {
  # Filter data for the current pair
  indices <- which(classes %in% pair)
  pair_data <- data[indices,]
  pair_classes <- classes[indices]

  # Convert 'pair_classes' into a factor with levels explicitly set to the current pair to ensure that the LDA function correctly interprets the classes and dont throw a warning
  pair_classes_factor <- factor(pair_classes, levels = pair)

  # Train LDA model using the filtered data and the factorized class labels
  lda_model <- lda(pair_data, grouping = pair_classes_factor)
  return(lda_model)
}

# A simple voting function for classification
predict_ovo <- function(models, new_sample, class_pairs) {
  # Initialize votes for each unique class, not pair
  unique_classes <- unique(unlist(class_pairs))
  votes <- numeric(length(unique_classes))
  names(votes) <- unique_classes

  for (i in seq_along(models)) {
    prediction <- predict(models[[i]], new_sample)$class
    # Increment votes for the predicted class
    votes[prediction] <- votes[prediction] + 1
  }

  # Return the class with the highest vote count
  return(names(which.max(votes)))
}

# Evaluating the model
# Split the data into training and testing sets
set.seed(123) # For reproducibility
total_samples <- nrow(fgl)
shuffled_indices <- sample(total_samples)
split_point <- round(total_samples * 0.8)

training_indices <- shuffled_indices[1:split_point]
testing_indices <- shuffled_indices[(split_point + 1):total_samples]

training_data <- fgl_data[training_indices,]
training_classes <- fgl_classes[training_indices]
testing_data <- fgl_data[testing_indices,]
testing_classes <- fgl_classes[testing_indices]

# Train models on the training set
training_class_pairs <- combn(unique(training_classes), 2, simplify = FALSE)
models <- lapply(training_class_pairs, train_lda_pair, data = training_data, classes = training_classes)

# Evaluate on the testing set
predictions <- sapply(1:nrow(testing_data), function(i) predict_ovo(models, testing_data[i, , drop = FALSE], training_class_pairs))
correct_predictions <- sum(predictions == testing_classes)
accuracy <- correct_predictions / length(testing_classes)

# Print the accuracy
print(paste("Accuracy:", accuracy))
