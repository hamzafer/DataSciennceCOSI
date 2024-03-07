# https://www.jetbrains.com/help/pycharm/setup-r-environment.html#workspace

x <- 5

names <- c("Ham", "Za", "Fer")
ages <- c(20, 30, 40)
goals <- c(3, 5, 1)

d <- data.frame(names, ages, goals)

f <- data.frame(row.names = names, ages, goals)

max(d$ages)
max(f$goals)
d[which(d$goals == max(d$goals)),]

par(mfrow = c(2, 2))
plot(d$ages, d$goals)
plot(d$ages, d$goals, type = "l")
plot(d$ages, d$goals, type = "l", col = "red")
plot(d$ages, d$goals, type = "l", col = "red", lwd = 3)

plot(1:10, 1:10, type = "l", col = "red", lwd = 3)
plot(1:10, 1:10, type = "l", col = "red", lwd = 3, xlim = c(0, 20), ylim = c(0, 20))

png("myplot.png")
dev.off()

print("Hello World")

# for (i in 1:4) {
#   print(i)
#   plot(1:i^i, 1:i^i, type="l", col="red", lwd=3)
# }
