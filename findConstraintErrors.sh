###################
#finds the CogniCrypt result files
#that contain at least one ConstraintError
#and moves those files to own dir
#
#
#this is for the constraintError FP study only
#obviously
#
#also generates a template file
#FPLogVx.txt for the next manual step,
#for the reviewer to fill out
#WARNING running this after fp detection has begun will remove your work
#either backup or dont run
#
#sample usage:
#   ./findConstraintErrors.sh FPV2Log.txt V2
###################
rm $1
rm ConstraintErrors$2.txt
mkdir resultsConstraintError$2

for file in ResultsWithObjects$2/*.txt; do
    if cat $file | grep -q "ConstraintError\:";then
	echo "$file" >> ConstraintErrors$2.txt
	echo "$file=" >> $1
	cp $file resultsConstraintError$2/${file#ResultsWithObjects$2/}
    fi  
done 

total=$(cat ConstraintErrors$2.txt | wc -l)
echo "Found this many outputs with at least one ConstraintError: $total"
