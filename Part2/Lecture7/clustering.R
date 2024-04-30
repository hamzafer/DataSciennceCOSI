# Load the iris dataset
data(iris)

# Select the first four columns (features) of the iris dataset
i.iris <- iris[, 1:4]

# Performing hierarchical clustering with different methods
# Complete linkage
h.complete <- hclust(dist(i.iris), method = "complete")
# Average linkage
h.average <- hclust(dist(i.iris), method = "average")
# Single linkage
h.single <- hclust(dist(i.iris), method = "single")

# Set up the plotting area to have 3 rows in one column
par(mfrow = c(1, 3))

# Plot dendrograms for each method
plot(h.complete, main = "Complete Linkage")
plot(h.average, main = "Average Linkage")
plot(h.single, main = "Single Linkage")

# Cut the dendrogram to create 2 clusters for complete linkage method
cutree(h.complete, 2)
