#!/usr/bin/Rscript

suppressPackageStartupMessages(
    {
        require(tidyverse)
        require(ape)
        require(phyclust)
        require(ggfortify)
        require(ggtree)
    })

args <- commandArgs(trailingOnly = TRUE)
input=args[1]
keep_num=args[2]
output=args[3]

x <- read.delim(input)
x <- subset(x, node.count > 10) # only keep apparently informative reads
y <- sample_n(x, ifelse(nrow(x) > keep_num, keep_num, nrow(x)))
y.matrix <- y[ , !names(y) %in% c("aln.name","query.length","node.count")]
y.dist <- dist(y.matrix)
y.tree <- nj(y.dist)
y.hclust <- hclust(y.dist)
#plot(y.hclust)
ggplot(y.tree) + geom_tree()
ggsave(output, height=8, width=5)
