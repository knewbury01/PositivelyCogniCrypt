########################
#collects the number of errors for each type
#
# sample usage:
#    ./collectErrorDist.sh ../CogniCryptResults V2ErrorDist
########################
rm Report.txt
rm allErrors.txt
cat $1/*.txt | grep "Error: " >> allErrors.txt

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

done <allErrors.txt

echo "ConstraintError=$ConstraintError"
echo "NeverTypeOfError=$NeverTypeOfError"
echo "ForbiddenMethodError=$ForbiddenMethodError"
echo "ImpreciseValueExtractionError=$ImpreciseValueExtractionError"
echo "TypestateError=$TypestateError"
echo "RequiredPredicateError=$RequiredPredicateError"
echo "IncompleteOperationError=$IncompleteOperationError"

echo "Constraint=$ConstraintError" >> Report.txt
echo "NeverTypeOf=$NeverTypeOfError" >> Report.txt
echo "ForbiddenMethod=$ForbiddenMethodError" >> Report.txt
echo "ImpreciseValueExt=$ImpreciseValueExtractionError" >> Report.txt
echo "Typestate=$TypestateError" >> Report.txt
echo "RequiredPredicate=$RequiredPredicateError" >> Report.txt
echo "IncompleteOp=$IncompleteOperationError" >> Report.txt

RScript CogSummary.r Report.txt $2
