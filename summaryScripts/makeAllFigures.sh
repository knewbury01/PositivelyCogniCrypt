#generates overall summary for cognicrypt outputs for cognicrypt 2.1
./summary.sh ../CogniCryptResults 
#1.0
./summary.sh ../CogniCryptResultsV1

#makes a figure of the distribution all error types for all outputs, for cognicrypt 2.1 
./collectErrorDist.sh ../CogniCryptResults V2ErrorDist V2.1
#1.0
./collectErrorDist.sh ../CogniCryptResultsV1 V1ErrorDist V1

#makes a figure of the distribution of constraint error totals, across projects, for cognicrypt 2.1
./getDistributionCountConstraintError.sh ../CogniCryptResults V21CEDist V2.1
#1.0
./getDistributionCountConstraintError.sh ../CogniCryptResultsV1 V10CEDist V1

#makes a table of the false positive results as in the logs
./makeFPCount.sh V2
#1.0
./makeFPCount.sh V1
