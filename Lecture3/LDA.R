library(MASS)
library(ISLR)
set.seed(2)
train <- sample(length(Default$default), length(Default$default)/2, replace=FALSE)
lda.model <- lda(default~balance+income, data=Default, subset=train)
# qda.model <- qda(default~balance+income, data=Default, subset=train)
lda.model
lda.pred <- predict(lda.model, newdata=Default[-train, ])
table(lda.pred$class, Default[-train, ]$default)
