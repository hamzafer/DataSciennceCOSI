# Notes:
# Aritificial regression, where we pretend one variable as a target variable and the rest as features
# Clustering...?
# difference reinforcement learning and unsupervised learning and semi-supervised learning
# Qs: how can we get more data for the brain MRI?

# Load the RSNNs library to use functions for neural networks
library(Rcpp)
library(RSNNS)
set.seed(123)

# Load the Iris dataset
data(iris)

# Randomly shuffle the rows of the Iris dataset
iris <- iris[sample(1:nrow(iris), length(1:nrow(iris))), 1:ncol(iris)]

# Separate the dataset into features and targets
irisValues <- iris[, 1:4]  # features
irisTargets <- iris[, 5]   # target variable

# Create a SOM model using the iris data
model <- som(irisValues, mapX = 16, mapY = 16, maxit = 500, targets = irisTargets)

# Plot the activation map of the SOM
plotActMap(model$map, col = rev(heat.colors(12)))

# Plot the activation map using a logarithmic scale
plotActMap(log(model$map + 1), col = rev(heat.colors(12)))

# Create a 3D perspective plot of the SOM
persp(1:model$archParams$mapX, 1:model$archParams$mapY, log(model$map + 1), theta = 30, phi = 30, expand = 0.5, col = "lightblue")

# Plot component maps for each feature
for (i in 1:ncol(irisValues)) {
  plotActMap(model$componentMaps[[i]], col = rev(topo.colors(12)))
}
