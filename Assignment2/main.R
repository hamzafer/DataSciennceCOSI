library(MASS)
data(fgl)
classes <- unique(fgl$type)
totalClasses <- nrow(table(classes))
# there are going to be 6 binary classifiers because there are 6 classes
# k ∈ {1 . . . K}. For each k, we create a binary classifier that distinguishes class k from the other K − 1 classes.
# Assuming the test data is taken out already

#Initialize Dataset Storage
ova_datasets <- list()

# New class label for all negative samples
new_negative_class_label <- "Rest"

for (class in classes) {
  positive_samples <- fgl[fgl$type == class,]
  negative_samples <- fgl[fgl$type != class,]

  # Assign a new unified class label to all negative samples for training purposes
  negative_samples$type <- new_negative_class_label

  # Combine positive and negative samples into a single dataset
  combined_training_set <- rbind(positive_samples, negative_samples)

  # Adjust the levels of the `type` column to reflect the new labeling 'Rest'
  combined_training_set$type <- factor(combined_training_set$type, levels = c(class, "Rest"))

  # Store the combined dataset in the ova_datasets list
  ova_datasets[[class]] <- combined_training_set
}

classes <- unique(ova_datasets[["WinF"]]$type)
classes # chechking the new labels

# Now, ova_datasets is a list of 6 datasets, each containing the combined training data for a class
# Example: To view the first few rows of the combined training data for "WinF"
print(ova_datasets[["WinF"]])
