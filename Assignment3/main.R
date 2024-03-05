library(MASS)
data(fgl)
set.seed(123)

classes <- unique(fgl$type)

# Calculate total number of classes
totalClasses <- nrow(table(classes))
# For the OVO strategy, we will create a binary classifier for each pair of classes.
# With 6 classes in this case, we have C(6, 2) = 6 * (6-1) / 2 = 15 binary classifiers.
# For each unique pair of classes (i, j), where i ≠ j and i, j ∈ {1 ... K}, we create a binary classifier that distinguishes class i from class j.

# Initialize list to store OVO datasets
ovo_datasets <- list()

# Generate all possible pairs of classes
class_pairs <- combn(classes, 2, simplify = FALSE)

training_percentage <- 0.7

for (pair in class_pairs) {
  class1_samples <- fgl[fgl$type == pair[1],]
  class2_samples <- fgl[fgl$type == pair[2],]

  training_indices_class1 <- sample(1:nrow(class1_samples), size = training_percentage * nrow(class1_samples))
  training_indices_class2 <- sample(1:nrow(class2_samples), size = training_percentage * nrow(class2_samples))

  training_set_class1 <- class1_samples[training_indices_class1,]
  training_set_class2 <- class2_samples[training_indices_class2,]
  testing_set_class1 <- class1_samples[-training_indices_class1,]
  testing_set_class2 <- class2_samples[-training_indices_class2,]

  training_set <- rbind(training_set_class1, training_set_class2)
  testing_set <- rbind(testing_set_class1, testing_set_class2)

  pair_name <- paste(pair, collapse = "_vs_")
  ovo_datasets[[pair_name]] <- list(training_set = training_set, testing_set = testing_set)
}

# Now the ovo_datasets list contains the datasets required for OVO scheme
# Moving onto Training LDA classifiers for each class pair
lda_classifiers <- list()
for (pair_name in names(ovo_datasets)) {
  dataset <- ovo_datasets[[pair_name]]
  lda_classifier <- lda(type ~ ., data = dataset$training_set)
  lda_classifiers[[pair_name]] <- lda_classifier
}

# At this point, `lda_classifiers` contains the trained LDA models for each class pair
# Example to show the LDA classifier for the first pair:
first_pair_name <- names(lda_classifiers)[1]
lda_classifiers[[first_pair_name]]
