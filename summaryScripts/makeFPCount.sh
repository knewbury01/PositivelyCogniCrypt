#################
#counts the number of FPs
#in the FPlog and puts into a table
#
#sample usage:
#  ./makeFPCount.sh V1
##################
totalFP=$(cat FP$1Log.txt | grep -o "FP" | wc -l)
total=$(cat FP$1Log.txt | wc -l)

#make this work in any dir durrr
RScript ../summaryScripts/makeTable.r $1.png $totalFP $total
