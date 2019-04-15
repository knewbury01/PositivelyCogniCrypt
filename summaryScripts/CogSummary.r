args = commandArgs(trailingOnly=TRUE)
d <- read.table(args[1], header=F, sep="=")
show(d)
show(d$V1)

png(file=args[2], width     = 3,
  height    = 3,
  units     = "in",
  res       = 1200,
  pointsize = 4)

x <- barplot(d$V2, xaxt="n",
main="Distribution of Error Types Found",
ylim=c(0,15),
ylab="Total Number of Occurrences")
labs <- paste(names(table(d$V1)))
text(cex=0.9, x=x-.25,
y=-1, labs, xpd=TRUE, srt=45)