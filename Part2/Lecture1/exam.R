library(tree)
load("kchousing.RData")

# Fit a large tree
tree.model <- tree(price ~ ., data = kchousing)

# Plot the cost complexity profile
plot(prune.tree(tree.model))

# Cross-validate to find optimal number of leaves
cv.tree <- cv.tree(tree.model, FUN=prune.tree)

# Plot the cross-validation result to find the minimum
plot(cv.tree)

# Prune the tree at the optimal size found from cross-validation
optimal_size <- which.min(cv.tree$dev)
pruned_model <- prune.tree(tree.model, best = optimal_size)

