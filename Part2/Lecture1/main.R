# Example: King County Housing tree

load("kchousing.RData")
library(tree)

# Build a decision tree model
tree.model <- tree(price ~ ., data = kchousing)

# Simplify the tree by pruning, best=number of nodes
smodel <- prune.tree(tree.model, best = 3)

# Plot the simplified model
plot(smodel)

# Add text labels to the plot
text(smodel)

# Print the summary of the simplified model
smodel

# Build a decision tree model (repeated line, might not be necessary)
model <- tree(price ~ ., data = kchousing)
