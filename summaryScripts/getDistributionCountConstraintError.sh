######################
#generates a barplot of the distribution
#of number of Constraint Errors per project
#
# sample usage:
#  ./getDistributionCountConstraintError.sh ../CogniCryptResults V21CEDist
######################
rm ConstraintErrorDistribution$2.txt
cat $1/*.txt |  grep "ConstraintError\:" |  sed 's/ConstraintError\: //' >> ConstraintErrorDistribution$2.txt

#sum the total objects found
total=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    total=$((total+line))
done <ConstraintErrorDistribution$2.txt

echo "Total number of constraint errors found: $total"

RScript constraintDist.r ConstraintErrorDistribution$2.txt $2.png
