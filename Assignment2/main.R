library(MASS)
data(fgl)
classes <- unique(fgl$type)
classes
totalClasses <- nrow(table(classes))
# there are going to be 6 binary classifiers because there are 6 classes
# k ∈ {1 . . . K}. For each k, we create a binary classifier that distinguishes class k from the other K − 1 classes.

# TODO: No transformation required for the test set.
# TODO: Need to group all the negative class samples in a new class

set.seed(123)
ova_datasets <- list()

training_percentage <- 0.7

for (class in classes) {
  positive_samples <- fgl[fgl$type == class,]
  negative_samples <- fgl[fgl$type != class,]

  training_indices_pos <- sample(1:nrow(positive_samples), size = training_percentage * nrow(positive_samples))
  training_indices_neg <- sample(1:nrow(negative_samples), size = training_percentage * nrow(negative_samples))

  training_set_pos <- positive_samples[training_indices_pos,]
  training_set_neg <- negative_samples[training_indices_neg,]
  testing_set_pos <- positive_samples[-training_indices_pos,]
  testing_set_neg <- negative_samples[-training_indices_neg,]

  ova_datasets[[class]] <- list(training_set_pos = training_set_pos, training_set_neg = training_set_neg, testing_set_pos = testing_set_pos, testing_set_neg = testing_set_neg)
}

# The ova_datasets list now contains the datasets required for OVA scheme
ova_datasets[["WinF"]]$training_set_pos
ova_datasets[["WinF"]]$training_set_neg
ova_datasets[["WinF"]]$testing_set_pos
ova_datasets[["WinF"]]$testing_set_neg

# Full approach explained in the explaination.md file
