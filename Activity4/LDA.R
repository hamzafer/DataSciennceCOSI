# Class 4 - Linear Discriminant Analysis

library(MASS)
library(ISLR)
set.seed(2)

# 75% of the samples of the data set should be used as train set and the rest as test set
train <- sample(seq_len(nrow(iris)), size = 0.75 * nrow(iris), replace = FALSE)

# Apply Linear Discriminant Analysis to the iris data set to obtain the Species.
lda.model <- lda(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = iris, subset = train)

lda.model

lda.pred <- predict(lda.model, newdata = iris[-train,])
table(lda.pred$class, iris[-train,]$Species)

# Are samples #3 and #7 used as train or test samples ?
sample_status <- ifelse(c(3, 7) %in% train, "Train", "Test")
names(sample_status) <- c("Sample #3", "Sample #7")
sample_status
