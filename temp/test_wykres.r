library(h5)
library(ggplot2)
library(reshape2)
library(dplyr)

test_name <- "fft"

f <- h5file("../tests/results.h5")
packages <- c("julia","octave","matlab","python","scilab")
max_input_size <- 7

results <- list()
removetop <- 6

for (package in packages) {
    results[[package]] <- matrix(0,max_input_size,length(f[test_name][package]["1"][])-removetop)
    for (input_size in 1:max_input_size) {
        res <- as.vector(f[test_name][package][toString(input_size)][])
        if (removetop != 0) {
            results[[package]][input_size,] <- res[-tail(order(res),removetop)]
        } else {
            results[[package]][input_size,] <- res
        }
    }
}


rowVars <- function(x) {
    rowSums((x - rowMeans(x))^2)/(dim(x)[2] - 1)
}

rowMax <- function(x) {
    apply(x, 1, max)
}

rowMin <- function(x) {
    apply(x, 1, min)
}

rowMedian <- function(x) {
    apply(x, 1, median)
}

#results <- lapply(results, function(vec) {
    #t(apply(vec, 1, function(v) v[v < max(v)]))
#})

stddev <- lapply(results, function(vec) {
    sqrt(rowVars(vec))
})

means <- lapply(results, rowMedian)
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


for (package in packages) {
    dev.new()
    par(mfrow=c(2,3),oma=c(0,0,2,0))
    for (i in 2:7) {
        plot(results[[package]][i,])
        title(10^{i})
    }
    title(package, outer=TRUE)
}
