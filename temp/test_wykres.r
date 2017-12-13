library(h5)
library(ggplot2)
library(reshape2)
library(dplyr)

test_name <- "sin"

f <- h5file("../tests/results.h5")

results <- list(
    julia=f[paste(test_name, "/julia", sep="")][],
    octave=f[paste(test_name, "/octave", sep="")][],
    matlab=f[paste(test_name, "/matlab", sep="")][],
    scilab=f[paste(test_name, "/scilab", sep="")][],
    python=f[paste(test_name, "/python", sep="")][]
)

rowVars <- function(x) {
  rowSums((x - rowMeans(x))^2)/(dim(x)[2] - 1)
}

stddev <- lapply(results, function(vec) {
    sqrt(rowVars(vec))
})
means <- lapply(results, function(vec) {
    rowMeans(vec)
})

means.molten <- as.data.frame(melt(means) %>% group_by(L1) %>% mutate(id = row_number()))
stddev.molten <- as.data.frame(melt(stddev) %>% group_by(L1) %>% mutate(id = row_number()))

yMin <- means.molten["value"] - stddev.molten["value"]
yMin[yMin < 1e-10] <- 1e-10
yMax <- means.molten["value"] + stddev.molten["value"]

ggplot(means.molten, aes(x=id, y=value, colour=L1)) + geom_errorbar(aes(ymin=yMin, ymax=yMax), width=.1) + scale_y_log10(limits=c(1e-10,NA)) + geom_point() + geom_line()

