library(MASS)
library(ROCR)
library(class)
library(DMwR2)

set.seed(2)
biopsy2 <- na.omit(biopsy)
#Make "malignant" the positive class
biopsy2$class <- factor(biopsy2$class, c("malignant", "benign"))

#Each of nine attributes has been scored on a scale of 1 to 10
#Just in case
names <- names(biopsy2)
scaled <- data.frame(biopsy2[, 1], scale(biopsy2[, c(-1, -11)]), biopsy2[, 11])
biopsy2 <- scaled
names(biopsy2) <- names

train <- sample(nrow(biopsy2), nrow(biopsy2) / 2, replace = FALSE)
train.set <- biopsy2[train, -1]
test.set <- biopsy2[-train, -1]

#Prior probabilities for each class.
total <- sum(table(biopsy2$class))
prior.prob <- c(table(biopsy2$class)[1] / total, table(biopsy2$class)[2] / total)

#Create model and predict labels of test samples
lda.model <- lda(class ~ ., data = train.set, prior = prior.prob)
lda.pred <- predict(lda.model, newdata = test.set)

#Get probabilities of positive class
adapted.pred <- lda.pred$posterior[, 1] #Probability of positive class
#ROCR requirement lowest level-->negative class
adapted.labels <- ifelse(test.set$class == "benign", 0, 1)

asessModel <- function(adapted.pred, adapted.labels)
{
  pred <- prediction(adapted.pred, adapted.labels)
  plot(performance(pred, 'tpr', 'fpr'))
  #print(performance(pred,'tpr','fpr'))
  auc <- performance(pred, measure = "auc")
  print(paste("AUC:", attr(auc, "y.values")[[1]]))
  #TPR, FPR and cutoff values
  #print(performance(pred, measure = "tpr")@y.values[[1]])
  #print(performance(pred, measure = "fpr")@y.values[[1]])
  #print (performance(pred,'tpr','fpr')@alpha.values[[1]])
  print("------")
  tpr <- performance(pred, measure = "tpr")@y.values[[1]]
  fpr <- performance(pred, measure = "fpr")@y.values[[1]]
  cut_values <- performance(pred, 'tpr', 'fpr')@alpha.values[[1]]
  return(list(tpr, fpr, cut_values))
}

######

# AUC = [1] 0.9940276
model_assessment <- asessModel(adapted.pred, adapted.labels)

tpr_values <- model_assessment[[1]]
fpr_values <- model_assessment[[2]]
cutoff_values <- model_assessment[[3]]

# Calculating the distance of each ROC point to the top left corner (0,1)
distances <- sqrt((0 - fpr_values)^2 + (1 - tpr_values)^2)
min_distance_index <- which.min(distances)

best_cutoff <- cutoff_values[min_distance_index]
best_tpr <- tpr_values[min_distance_index]
best_fpr <- fpr_values[min_distance_index]

print(paste("Best cutoff value is:", best_cutoff))
print(paste("Corresponding TPR:", best_tpr))
print(paste("Corresponding FPR:", best_fpr))
