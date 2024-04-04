# Example: King County Housing tree

load("breast_cancer.RData")
library(tree)

breast_cancer$diagnosis <- as.factor(breast_cancer$diagnosis)

# Build a decision tree model
tree.model <- tree(diagnosis ~ ., data = breast_cancer)

plot(tree.model)

# Simplify the tree by pruning, best=number of nodes
smodel <- prune.tree(tree.model, best = 3)

# Plot the simplified model
plot(smodel)

# Add text labels to the plot
text(smodel)

# Print the summary of the simplified model
smodel

# Build a decision tree model (repeated line, might not be necessary)
model <- tree(diagnosis ~ ., data = breast_cancer)
