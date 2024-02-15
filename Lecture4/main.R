# Topic 4: Classification

dataset <- iris
levels(dataset$Species)
dataset$Species <- factor(dataset$Species, levels = c(levels(dataset$Species), "Unknown"))
levels(dataset$Species)
toBeChanged <- sample(nrow(dataset), 0.1 * nrow(dataset), replace = FALSE)
dataset[toBeChanged,]["Species"] <- "Unknown"
levels(dataset$Species)

