library(h5)
library(ggplot2)
library(reshape2)
library(dplyr)

test_name <- "fft"

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

rowMax <- function(x) {
    apply(x, 1, max)
}

rowMin <- function(x) {
    apply(x, 1, min)
}

#results <- lapply(results, function(vec) {
    #t(apply(vec, 1, function(v) v[v < max(v)]))
#})

stddev <- lapply(results, function(vec) {
    sqrt(rowVars(vec))
})

means <- lapply(results, rowMeans)
mins <- lapply(results, rowMin)
maxs <- lapply(results, rowMax)

means.molten <- as.data.frame(melt(means) %>% group_by(L1) %>% mutate(id = row_number()))
stddev.molten <- as.data.frame(melt(stddev) %>% group_by(L1) %>% mutate(id = row_number()))
mins.molten <- as.data.frame(melt(mins) %>% group_by(L1) %>% mutate(id = row_number()))
maxs.molten <- as.data.frame(melt(maxs) %>% group_by(L1) %>% mutate(id = row_number()))

#yMin <- means.molten["value"] - stddev.molten["value"]
#yMin[yMin < 1e-10] <- 1e-10
#yMax <- means.molten["value"] + stddev.molten["value"]

means.molten["VectorSize"] <- 10^means.molten["id"]

ggplot(means.molten, aes(x=VectorSize, y=value, colour=L1)) + geom_errorbar(aes(ymin=mins.molten["value"], ymax=maxs.molten["value"]), width=.1) + scale_y_log10() + scale_x_log10() + geom_point() + geom_line()

