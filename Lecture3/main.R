# Classifications: Lecture3

library(class)
library(ISLR)
set.seed(2)
train <- sample(length(Default$default), length(Default$default) / 2, replace = FALSE)
model5 <- knn(Default[train, c('balance', 'income')],
              Default[-train, c('balance', 'income')],
              Default$default[train], k = 5, prob = TRUE)
t <- table(model5, Default$default[-train])
cat("t", t, "\n")
accuracy <- (t[1, 1] + t[2, 2]) / sum(t)
cat("Accuracy", accuracy, "\n")
