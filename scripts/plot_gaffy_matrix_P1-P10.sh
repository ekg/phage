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
#keep_num=args[2]
output=args[2]

y <- read.delim(input)
# correct factor order
y$group.name <- factor(as.character(y$group.name), levels=c("P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10"))

#x <- subset(x, node.count > 10) # only keep apparently informative reads
#if (nrow(x) <= keep_num) {
#y <- x
#} else {
#   y <- sample_n(x, keep_num)
#}
ggplot(y, aes(x=query.length, color=group.name)) + geom_density() + scale_color_manual("passage",values=c(rainbow(12)[0:10], 'black'))
ggsave(paste(output, "query.length.density.pdf", sep="."), height=6, width=10)
ggplot(y, aes(x=query.length, fill=group.name)) + geom_histogram(binwidth=50) + scale_fill_manual("passage",values=c(rainbow(12)[0:10], 'black'))
ggsave(paste(output, "query.length.hist.pdf", sep="."), height=6, width=10)

y.matrix <- y[ , !names(y) %in% c("group.name","aln.name","query.length","node.count")]
y.dist <- dist(y.matrix)
y.tree <- nj(y.dist)
y.hclust <- hclust(y.dist)

pdf(paste(output, "hclust.pdf", sep="."), height=8, width=8)
plot(y.hclust)
dev.off()

ggtree(y.tree) %<+% data.frame(node=1:nrow(y.tree$edge), group.name=factor(c(as.character(y$group.name),rep("internal",nrow(y.tree$edge)-nrow(y))), levels=c(levels(y$group.name),"internal") )) + aes(color=group.name) + geom_tree() + scale_color_manual("passage",values=c(rainbow(12)[0:10], 'black'))
ggsave(paste(output, "ggtree.passage.pdf", sep="."), height=40, width=9)

# takes forever
#ggtree(y.tree, layout="unrooted") %<+% data.frame(node=1:nrow(y.tree$edge), group.name=factor(c(as.character(y$group.name),rep("internal",nrow(y.tree$edge)-nrow(y))), levels=c(levels(y$group.name),"internal") )) + aes(color=group.name) + geom_tree() + scale_color_manual("passage",values=c(rainbow(12)[0:10], 'black'))
#ggsave(paste(output, "ggtree.passage.unrooted.pdf", sep="."), height=40, width=9)

ggtree(y.tree) %<+% data.frame(node=1:nrow(y.tree$edge), query.length=c(y$query.length,rep(0,nrow(y.tree$edge)-nrow(y)))) + aes(color=query.length) + geom_tree()
ggsave(paste(output, "ggtree.query.length.pdf", sep="."), height=40, width=9)

ggtree(y.tree) %<+% data.frame(node=1:nrow(y.tree$edge), node.count=c(y$node.count,rep(0,nrow(y.tree$edge)-nrow(y)))) + aes(color=node.count) + geom_tree()
ggsave(paste(output, "ggtree.node.count.pdf", sep="."), height=40, width=9)

.Color <- rainbow(12)[0:10]
pdf(paste(output, "phylo.p.pdf", sep="."), height=40, width=9)
plotnj(y.tree, X.class=as.numeric(y$group.name), type='p', main='phylogeny of 5-45kb nanopore reads for B1phi1 1st BL21\ncorrected against run1.B1phi1.i1 compressed assembly graph'); legend("bottomright", inset=0, title="Passage sample id", c(as.character(c(1:10))), fill=.Color, cex=0.8)
dev.off()

pdf(paste(output, "phylo.u.pdf", sep="."), height=9, width=9)
plotnj(y.tree, X.class=as.numeric(y$group.name), type='u', main='phylogeny of 5-45kb nanopore reads for B1phi1 1st BL21\ncorrected against run1.B1phi1.i1 compressed assembly graph'); legend("topleft", inset=0, title="Passage sample id", c(as.character(c(1:10))), fill=.Color, cex=0.8)
dev.off()

y.pca <- prcomp(y.matrix)
y.pca.df <- as.data.frame(y.pca$x)
y.pca.df$group.name <- y$group.name
ggplot(y.pca.df, aes(x=PC1, y=PC2, color=group.name)) + geom_point() + scale_color_manual("passage",values=c(rainbow(12)[0:10], 'black'))
ggsave(paste(output, "pca.PC1.PC2.pdf", sep="."), height=8, width=9)
ggplot(y.pca.df, aes(x=PC2, y=PC3, color=group.name)) + geom_point() + scale_color_manual("passage",values=c(rainbow(12)[0:10], 'black'))
ggsave(paste(output, "pca.PC2.PC3.pdf", sep="."), height=8, width=9)
ggplot(y.pca.df, aes(x=PC3, y=PC4, color=group.name)) + geom_point() + scale_color_manual("passage",values=c(rainbow(12)[0:10], 'black'))
ggsave(paste(output, "pca.PC3.PC4.pdf", sep="."), height=8, width=9)
ggplot(y.pca.df, aes(x=PC4, y=PC5, color=group.name)) + geom_point() + scale_color_manual("passage",values=c(rainbow(12)[0:10], 'black'))
ggsave(paste(output, "pca.PC4.PC5.pdf", sep="."), height=8, width=9)
