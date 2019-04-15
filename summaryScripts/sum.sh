####################
#adds up the total number of errors across set of reports
#
#sample usage:
#  ./sum.sh <file-to-sum>
####################

sum=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    sum=$((sum+line))
done <"$1"

echo "$sum"
