## Approach to prepare OVA Dataset for Classification

### Steps Followed:

1. **Load Dataset and Identify Classes:**
    - The `fgl` dataset is loaded, and the unique classes (types of glass) are identified.

2. **Set Seed for Reproducibility:**
    - `set.seed(123)` ensures that our random operations can be replicated.

3. **Initialize Dataset Storage:**
    - An empty list `ova_datasets` is created to store the subsets for each class.

4. **Split Data for Each Class:**
    - k ∈ {1 . . . K}. For each k, we create a binary classifier that distinguishes class k from the other K − 1
      classes.
    - For each class in `classes`, we:
        - Identify `positive_samples` (samples of the current class).
        - Identify `negative_samples` (samples of all other classes).
        - Randomly split the positive and negative samples into training (70%) and testing (30%) sets.

5. **Store Subsets in List:**
    - For each class, we store four subsets in `ova_datasets`:
        - `training_set_pos`: Training data of the current class.
        - `training_set_neg`: Training data of all other classes.
        - `testing_set_pos`: Testing data of the current class.
        - `testing_set_neg`: Testing data of all other classes.

6. **Accessing the Data:**
    - The subsets for any class can be accessed using `ova_datasets[["ClassName"]]$subset_name`, where `ClassName` is
      the name of the class and `subset_name` is one of the four subsets.

### Example Usage:

To access the positive training samples for the class "WinFol", we use:

```r
ova_datasets[["WinF"]]$training_set_pos
