#################
#counts the number of FPs
#in the FPlog and puts into a table
#
#sample usage:
#  ./makeFPCount.sh V1
##################
totalFP=$(cat FP$1Log.txt | grep -q "FP" | wc -l)
total=$(cat FP$1Log.txt | wc -l)

RScript makeTable.r $1.png $totalFP $total
