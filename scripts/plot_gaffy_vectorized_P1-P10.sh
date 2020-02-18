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
output=args[2]

v <- read.delim(input)
v$group.name <- factor(as.character(v$group.name), levels=c("P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10"))
v$aln.id <- 1:nrow(v)

ggplot(v, aes(y=aln.id, x=node.id, color=group.name)) + geom_tile() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_rect(fill = 'black', colour = 'black')) + scale_color_manual("passage",values=c(rainbow(12)[0:10]))
ggsave(paste(output, "tile.group_name.black.pdf", sep="."), height=10, width=15)

ggplot(v, aes(y=query.length, x=node.id, color=group.name)) + geom_tile() +  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_rect(fill = 'black', colour = 'black')) + scale_color_manual("passage",values=c(rainbow(12)[0:10]))
ggsave(paste(output, "tile.query_length.black.pdf", sep="."), height=10, width=15)
