## Approach to prepare OVO Dataset for Binary Classification

### Steps Followed:

1. **Load Dataset and Identify Classes:**
    - The `fgl` dataset is loaded, and the unique classes (types of glass) are identified.

2. **Set Seed for Reproducibility:**
    - `set.seed(123)` ensures that our random operations can be replicated.

3. **Initialize Dataset Storage:**
    - An empty list `ovo_datasets` is created to store the training and testing sets for each pair of classes.

4. **Generate Class Pairs:**
    - With 6 classes in the dataset, we create C(6, 2) = 15 unique classifiers.
    - We use `combn` to generate all possible pairs of classes.

5. **Split Data for Each Class Pair:**
    - For each pair of classes (i, j), we:
        - Identify samples from both classes.
        - Randomly split the samples from each class into training (70%) and testing (30%) sets.
        - This is variable in `training_percentage` in code

6. **Store Subsets in List:**
    - For each class pair, we combine their respective training and testing samples and store them in `ovo_datasets`:
        - `training_set`: Combined training data for the current class pair.
        - `testing_set`: Combined testing data for the current class pair.

7. **Accessing the Data:**
    - The subsets for any class pair can be accessed using `ovo_datasets[["Class1_vs_Class2"]]$subset_name`,
      where `Class1` and `Class2` are the names of the classes in the pair, and `subset_name` is either `training_set`
      or `testing_set`.

8. **Adjusting Factor Levels for LDA Training:**
    - Before training LDA classifiers, we adjust the levels of the `type` factor in the training set to only include the
      two classes involved in each classifier. This ensures that the LDA function correctly models the binary
      classification for each class pair without any empty group warnings.

9. **Train LDA Classifiers for Each Class Pair:**
    - We train an LDA classifier for each pair of classes using the adjusted datasets. Each classifier is trained to
      distinguish between the two classes in its pair.

### Example Usage:

To access the training samples for the first pair of classes, you would use:

```r
first_pair_name <- names(ovo_datasets)[1]
ovo_datasets[[first_pair_name]]$training_set
```

To access the trained LDA classifier for the first pair of classes, you would use:

```r
first_pair_name <- names(lda_classifiers)[1]
lda_classifiers[[first_pair_name]]
```
