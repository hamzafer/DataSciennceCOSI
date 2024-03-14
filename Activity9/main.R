# Random Oversampling
library(ISLR)
set.seed(123)

class_distribution <- table(Default$default)

majority_class <- names(which.max(class_distribution))
minority_class <- names(which.min(class_distribution))

data_majority <- Default[Default$default == majority_class,]
data_minority <- Default[Default$default == minority_class,]

data_minority_oversampled <- data_minority[sample(1:nrow(data_minority), size = nrow(data_majority), replace = TRUE),]

data_balanced <- rbind(data_majority, data_minority_oversampled)

table(data_balanced$default)

nrow(data_balanced)

# > table(data_balanced$default)
#
#   No  Yes
# 9667 9667

# In this case, the total count after Random Oversampling will be 2 * 9667 = 19334
# This is because we oversampled the minority class to match the size of the majority class
