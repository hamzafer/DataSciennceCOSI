# Example: iris plants

library(class)
data(iris)
library(tree)

iris.tree <- tree(Species ~ ., iris)
plot(iris.tree)
text(iris.tree)
iris.tree
