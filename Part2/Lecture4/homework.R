library(kernlab)
set.seed(1)

# Function to generate spiral data
generate_spiral <- function(points, noise = 0.2) {
  theta <- runif(points, 0, 4 * pi)
  radius <- theta
  x <- radius * cos(theta) + rnorm(points, sd = noise)
  y <- radius * sin(theta) + rnorm(points, sd = noise)
  class <- as.factor(ifelse(theta < 2 * pi, 1, 2))
  data.frame(x = x, y = y, class = class)
}

# Generate data
data <- generate_spiral(200)

# Transform to polar coordinates
data$polar_radius <- sqrt(data$x^2 + data$y^2)
data$polar_angle <- atan2(data$y, data$x)

# Plot to verify transformation
plot(data$polar_radius, data$polar_angle, col = data$class)

# Train SVM model
svm_model <- ksvm(class ~ polar_radius + polar_angle, data = data, kernel = "rbfdot")


# Prediction grid
grid_points <- expand.grid(polar_radius = seq(min(data$polar_radius), max(data$polar_radius), length.out = 100),
                           polar_angle = seq(min(data$polar_angle), max(data$polar_angle), length.out = 100))

# Predict
grid_points$class <- predict(svm_model, grid_points)

# Visualization
plot(grid_points$polar_radius, grid_points$polar_angle, col = grid_points$class, pch = 20, cex = 0.5)

# Calculate accuracy
predictions <- predict(svm_model, newdata = data)
correct_predictions <- sum(predictions == data$class)
total_predictions <- nrow(data)
accuracy <- correct_predictions / total_predictions
cat("\nAccuracy:", accuracy * 100, "%")
