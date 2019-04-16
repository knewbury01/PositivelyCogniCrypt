png(file=args[1], width     = 2.25,
  height    = 2.25,
  units     = "in",
  res       = 1200,
  pointsize = 4)

args = commandArgs(trailingOnly=TRUE)
counts<- table(args[3], args[2])

colnames(counts) <- c("Total Warnings" , "False Positives")
rownames(counts) <- c("Constraints")
show(counts)

library(gridExtra)
library(grid)

grid.table(counts)