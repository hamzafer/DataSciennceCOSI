## Approach to prepare OVA Dataset for Classification

### Steps Followed:

1. **Initialize Dataset Storage:**
    - An empty list named `ova_datasets` is initialized. This list is used to store the combined training dataset for
      each class, where each dataset includes positive samples from the target class and negative samples from all other
      classes, labeled as "Rest".

2. **Combine Data for Each Class:**
    - For each class identified in the dataset (`classes`)
        - Positive samples (samples belonging to the current class) are identified and kept with their original class
          label.
        - Negative samples (samples not belonging to the current class) are also identified. These samples are then
          labeled with a new, unified class label, "Rest", to distinguish them from the positive samples.
        - **Adjust Factor Levels for Class Label:** After combining, adjust the levels of the `type` column to reflect
          the new labeling 'Rest'.
        - Positive and negative samples are combined into a single dataset for each class. This combined dataset is
          ready for use in training a binary classifier, following the One-vs-All (OVA) strategy.

3. **Store Combined Datasets in List:**
    - The combined dataset for each class is stored in the `ova_datasets` list using `rbind` with the class name as the
      key.

### Accessing the Data:

- To access the combined training dataset for any specific class, you can refer to the `ova_datasets` list using the
  class name as the key. For example, to access the combined training data for the "WinF" class, use the following
  command:

```r
combined_training_data_winF <- ova_datasets[["WinF"]]
