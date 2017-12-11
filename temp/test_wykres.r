library(h5)
library(ggplot2)
library(reshape2)

test_name <- "sin"

f <- h5file("../tests/results.h5")

results <- list(
    julia=f[paste(test_name, "/julia", sep="")][],
    octave=f[paste(test_name, "/octave", sep="")][],
    matlab=f[paste(test_name, "/matlab", sep="")][],
    scilab=f[paste(test_name, "/scilab", sep="")][][,],
    python=f[paste(test_name, "/python", sep="")][]
)
stddev <- as.data.frame(unlist(lapply(results, function(vec) {
    sqrt(var(vec))
})))
means <- as.data.frame(unlist(lapply(results, function(vec) {
    mean(vec)
})))

means["Software"] <- rownames(means)
means.molten <- melt(means, id.vars="Software", value.name="ExecutionTime")
means["Software"] <- c()

ggplot(means.molten, aes(x=Software, y=ExecutionTime)) + geom_errorbar(aes(ymin=means-stddev, ymax=means+stddev), colour="red", width=.1) + geom_point()

