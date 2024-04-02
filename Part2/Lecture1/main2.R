# Example: iris plants

library(class)
data(iris)
library(tree)

iris.tree <- tree(Species ~ ., iris)
plot(iris.tree)
text(iris.tree)
iris.tree

# means that the setosa is just easy to classify
# also the 4th variable is not even used in the tree
# thats why trees are useful for feature selection
