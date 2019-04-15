######################
#generates a barplot of the distribution
#of number of Constraint Errors per project
#
# sample usage:
#  ./getDistributionCountConstraintError.sh ../CogniCryptResults V2.1CEDist.png
######################
rm ConstraintErrorDistribution.txt
cat $1/*.txt |  grep "ConstraintError\:" |  sed 's/ConstraintError\: //' >> ConstraintErrorDistribution.txt

#sum the total objects found
total=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    total=$((total+line))
done <ConstraintErrorDistribution.txt

echo "Total number of constraint errors found: $total"

RScript constraintDist.r ConstraintErrorDistribution.txt $2
