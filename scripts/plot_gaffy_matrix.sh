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
if (nrow(x) <= keep_num) {
   y <- x
} else {
   y <- sample_n(x, keep_num)
}
y.matrix <- y[ , !names(y) %in% c("aln.name","query.length","node.count")]
y.dist <- dist(y.matrix)
y.tree <- nj(y.dist)
y.hclust <- hclust(y.dist)
#plot(y.hclust)
ggplot(y.tree) + geom_tree()
ggsave(paste(output, "tree.pdf", sep="."), height=8, width=5)
y.pca <- prcomp(y.matrix); ggplot(y.pca$x, aes(x=PC1, y=PC2)) + geom_point()
ggsave(paste(output, "pca.PC1.PC2.pdf", sep="."), height=8, width=8)
y.pca <- prcomp(y.matrix); ggplot(y.pca$x, aes(x=PC2, y=PC3)) + geom_point()
ggsave(paste(output, "pca.PC2.PC3.pdf", sep="."), height=8, width=8)
y.pca <- prcomp(y.matrix); ggplot(y.pca$x, aes(x=PC3, y=PC4)) + geom_point()
ggsave(paste(output, "pca.PC3.PC4.pdf", sep="."), height=8, width=8)
