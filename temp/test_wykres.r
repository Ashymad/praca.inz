library(h5)
library(ggplot2)
library(reshape2)

f <- h5file("../tests/results.h5")

results <- list(
    julia=f["sin/julia"][],
    octave=f["sin/octave"][],
    matlab=f["sin/matlab"][],
    scilab=f["sin/scilab"][][,],
    python=f["sin/python"][]
)
stddev <- as.data.frame(unlist(lapply(results, function(vec) {
    sqrt(var(vec))
})))
means <- as.data.frame(unlist(lapply(results, function(vec) {
    mean(vec)
})))

means["Software"] = rownames(means)
means.molten = melt(means, id.vars="Software", value.name="ExecutionTime")
means["Software"] = c()

ggplot(means.molten, aes(x=Software, y=ExecutionTime)) + geom_errorbar(aes(ymin=means-stddev, ymax=means+stddev), colour="red", width=.1) + geom_point()

