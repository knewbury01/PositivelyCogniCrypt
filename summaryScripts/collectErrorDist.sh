########################
#collects the number of errors for each type
#
# sample usage:
#    ./collectErrorDist.sh ../CogniCryptResults V2ErrorDist V2
########################
rm Report$2.txt
rm allErrors$2.txt
cat $1/*.txt | grep "Error: " >> allErrors$2.txt

ConstraintError=0
NeverTypeOfError=0
ForbiddenMethodError=0
#I think this is deprecated 2.1 but ok incl just in case
ImpreciseValueExtractionError=0
TypestateError=0
RequiredPredicateError=0
IncompleteOperationError=0

while IFS='' read -r line || [[ -n "$line" ]]; do

    num=$(echo "$line" | sed 's/[^0-9]*//g')
    if echo "$line" | grep -q "ConstraintError:";then
	ConstraintError=$((ConstraintError+num))
    fi   
    if echo "$line" | grep -q "NeverTypeOfError:";then
       NeverTypeOfError=$((NeverTypeOfError+num))
    fi
    if echo "$line" | grep -q "ForbiddenMethodError:";then
       ForbiddenMethodError=$((ForbiddenMethodError+num))
    fi
   if echo "$line" | grep -q "ImpreciseValueExtractionError:";then
       ImpreciseValueExtractionError=$((ImpreciseValueExtractionError+num))
   fi
      if echo "$line" | grep -q "TypestateError:";then
       TypestateError=$((TypestateError+num))
      fi
	 if echo "$line" | grep -q "RequiredPredicateError:";then
       RequiredPredicateError=$((RequiredPredicateError+num))
	 fi
    if echo "$line" | grep -q "IncompleteOperationError:";then
       IncompleteOperationError=$((IncompleteOperationError+num))
    fi

done <allErrors$2.txt

echo "ConstraintError=$ConstraintError"
echo "NeverTypeOfError=$NeverTypeOfError"
echo "ForbiddenMethodError=$ForbiddenMethodError"
echo "ImpreciseValueExtractionError=$ImpreciseValueExtractionError"
echo "TypestateError=$TypestateError"
echo "RequiredPredicateError=$RequiredPredicateError"
echo "IncompleteOperationError=$IncompleteOperationError"

echo "Constraint=$ConstraintError" >> Report$2.txt
echo "NeverTypeOf=$NeverTypeOfError" >> Report$2.txt
echo "ForbiddenMethod=$ForbiddenMethodError" >> Report$2.txt
echo "ImpreciseValueExt=$ImpreciseValueExtractionError" >> Report$2.txt
echo "Typestate=$TypestateError" >> Report$2.txt
echo "RequiredPredicate=$RequiredPredicateError" >> Report$2.txt
echo "IncompleteOp=$IncompleteOperationError" >> Report$2.txt

RScript CogSummary.r Report$2.txt $2.png "Distribution of Total # Errors Found $3"
