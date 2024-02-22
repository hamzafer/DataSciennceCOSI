# Apply the KNN imputation technique on the biopsy (MASS) dataset to estimate missing values.
library(MASS)
data(biopsy)
library(DMwR2)
set.seed(2)

missing_values <- sapply(biopsy, function(x) any(is.na(x)))
print(missing_values)
# From the output, we can see that the V6 column contains missing values.

# Create a copy of biopsy with missing values
biopsy.missing <- biopsy
selected <- sample(nrow(biopsy.missing), 5)

# Perform KNN imputation
biopsy.filled <- knnImputation(biopsy.missing, k = 5)  # uses weighted average and scales by default

# Calculate relative differences between real and estimated values
relative_differences <- (biopsy[selected, 'V6'] - biopsy.filled[selected, 'V6']) / biopsy[selected, 'V6']

# Print the relative differences
print(relative_differences)
