#############################
#Counts the total number of errors
#related to MessageDigest.getInstance()
#in some set of reports
#
#does this by only looking at portion of report after
#keyword "Findings"
#
#sample usage:
#    ./countMDGetInstances.sh ResultsWithObjects
#
#############################
total=0
for file in $1/*.txt; do
    filetot=$(cat $file | sed -n '/Findings/,$p' | grep "MessageDigest getInstance" | wc -l)
    total=$((total+filetot))
    echo "$file had: $filetot"
done 

echo "The total number of errors related to MessageDigest.getInstance is: $total"
