library(h5)
library(ggplot2)
library(reshape2)
library(dplyr)

graphics.off()

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

shaveoff  <- function(vec, max_ratio) {
    vec[-tail(order(vec),5)]
}

getResults <- function(f, test_name) {
    packages <- c("julia","octave","matlab","python","scilab")
    max_input_size <- length(list.datasets(f[test_name]["octave"]))
    max_ratio  <- 2.5
    results <- list()
    for (package in packages) {
        number_of_tests  <- length(f[test_name][package]["1"][])
        results[[package]] <- matrix(NA,max_input_size,number_of_tests)
        for (input_size in 1:max_input_size) {
            res <- shaveoff(as.vector(f[test_name][package][toString(input_size)][]),max_ratio)
            results[[package]][input_size,1:length(res)] <- res
        }
    }
    results
}

preparePlot <- function(results) {
    means <- lapply(results, rowMedian)
    mins <- lapply(results, rowMin)
    maxs <- lapply(results, rowMax)

    means.molten <- as.data.frame(melt(means) %>% group_by(L1) %>% mutate(id = row_number()))
    mins.molten <- as.data.frame(melt(mins) %>% group_by(L1) %>% mutate(id = row_number()))
    maxs.molten <- as.data.frame(melt(maxs) %>% group_by(L1) %>% mutate(id = row_number()))

    means.molten["VectorSize"] <- 10^means.molten["id"]

    plot <- ggplot(means.molten, aes(x=VectorSize, y=value, colour=L1)) 
    plot <- plot + geom_errorbar(aes(ymin=mins.molten["value"], ymax=maxs.molten["value"]), width=.1)
    plot <- plot + scale_y_log10() + scale_x_log10() + geom_point() + geom_line()
    plot <- plot + xlab("Wielkość wektora wejściowego") + ylab("Czas wykonywania procedury [\\si{\\seconds}]")
    plot <- plot + labs(colour="Pakiet obliczeniowy")
    plot
}

test_name <- "conv"

file <- h5file("../tests/results.h5")

results <- getResults(file, test_name)

preparePlot(results)
