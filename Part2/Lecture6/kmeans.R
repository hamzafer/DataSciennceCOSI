set.seed(2)
x <- matrix(rnorm(50 * 2), ncol = 2)
x[1:25, 1] <- x[1:25, 1] + 3
x[1:25, 2] <- x[1:25, 2] - 4

km.out <- kmeans(x, 2, nstart = 20)
km.out$cluster

plot(x, col = (km.out$cluster + 1), main = "K Means Clustering Results with K=2", xlab = "", ylab = "", pch = 20, cex = 2)

set.seed(4)
km.out <- kmeans(x, 3, nstart = 20)
km.out

set.seed(3)
km.out <- kmeans(x, 3, nstart = 1)
km.out$tot.withinss

km.out <- kmeans(x, 3, nstart = 20)
km.out$tot.withinss
