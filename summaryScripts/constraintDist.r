args = commandArgs(trailingOnly=TRUE)
counts<- read.table(args[1], header=F)


png(file=args[2], width     = 2.25,
  height    = 2.25,
  units     = "in",
  res       = 1200,
  pointsize = 4)


show(counts)
table(counts$V1)

barplot(table(counts$V1),

main ="Distribution of Constraint Error Totals Found Across Projects",
ylab="Number of Projects Containing that Number of Constraint Error Occurrences",
xlab="Number of Constraint Errors",
ylim=c(0, 7)
)