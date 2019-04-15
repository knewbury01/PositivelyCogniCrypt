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
#FPLog.txt for the next manual step,
#for the reviewer to fill out
#WARNING running this after fp detection has begun will remove your work
#either backup or dont run
###################
rm FPLog.txt
rm ConstraintErrors.txt
mkdir resultsConstraintError

for file in ResultsWithObjects/*.txt; do
    if cat $file | grep -q "ConstraintError\:";then
	echo "$file" >> ConstraintErrors.txt
	echo "$file=" >> FPLog.txt
	cp $file resultsConstraintError/${file#ResultsWithObjects/}
    fi  
done 

total=$(cat ConstraintErrors.txt | wc -l)
echo "Found this many outputs with at least one ConstraintError: $total"
