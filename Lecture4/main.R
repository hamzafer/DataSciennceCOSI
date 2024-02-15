# Topic 4: Classification
library(MASS)

dataset <- iris
levels(dataset$Species)
dataset$Species <- factor(dataset$Species, levels = c(levels(dataset$Species), "Unknown"))
levels(dataset$Species)
toBeChanged <- sample(nrow(dataset), 0.1 * nrow(dataset), replace = FALSE)
dataset[toBeChanged,]["Species"] <- "Unknown"
levels(dataset$Species)
table(dataset$Species)

not_setosa_subset <- iris[-which(iris$Species == "setosa"),]
lda(Species ~ ., data = not_setosa_subset)

