library(h5)
library(ggplot2)
library(reshape2)
library(dplyr)

graphics.off()

test_name <- "conv"

f <- h5file("../tests/results.h5")
packages <- c("julia","octave","matlab","python","scilab")
max_input_size <- length(list.datasets(f[test_name]["octave"]))
max_ratio  <- 1.5

shaveoff  <- function(vec, max_ratio) {
    while (max(vec)/median(vec) > max_ratio) {
        vec  <- vec[which(vec != max(vec))]
    }
    vec
}

results <- list()
for (package in packages) {
    number_of_tests  <- length(f[test_name][package]["1"][])
    results[[package]] <- matrix(NA,max_input_size,number_of_tests)
    for (input_size in 1:max_input_size) {
        res <- shaveoff(as.vector(f[test_name][package][toString(input_size)][]),max_ratio)
        results[[package]][input_size,1:length(res)] <- res
    }
}


rowMax <- function(x) {
    apply(x, 1, function(e) {
          max(e, na.rm=TRUE)
    })
}

rowMin <- function(x) {
    apply(x, 1, function(e) {
          min(e, na.rm=TRUE)
    })
}

rowMedian <- function(x) {
    apply(x, 1, function(e) {
          median(e, na.rm=TRUE)
    })
}

rowCountNA  <- function(x) {
    apply(x, 1, function(e) {
          sum(is.na(e))/length(e)
    })
}

naperc  <- lapply(results, rowCountNA)
means <- lapply(results, rowMedian)
mins <- lapply(results, rowMin)
maxs <- lapply(results, rowMax)

means.molten <- as.data.frame(melt(means) %>% group_by(L1) %>% mutate(id = row_number()))
mins.molten <- as.data.frame(melt(mins) %>% group_by(L1) %>% mutate(id = row_number()))
maxs.molten <- as.data.frame(melt(maxs) %>% group_by(L1) %>% mutate(id = row_number()))

means.molten["VectorSize"] <- 10^means.molten["id"]

ggplot(means.molten, aes(x=VectorSize, y=value, colour=L1)) + geom_errorbar(aes(ymin=mins.molten["value"], ymax=maxs.molten["value"]), width=.1) + scale_y_log10() + scale_x_log10() + geom_point() + geom_line()


#for (package in packages) {
#    dev.new()
#    par(mfrow=c(2,3),oma=c(0,0,2,0))
#    for (i in 2:max_input_size) {
#        plot(results[[package]][i,])
#        title(10^{i})
#    }
#    title(package, outer=TRUE)
#}
