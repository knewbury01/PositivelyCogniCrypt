#######################
#not all projects will actually have
#an object of interest to analyze potentially
#so assure that the outputs we look at
#did have an interesting result
#
# sample usage:
#    ./partitionCogniResults.sh CogniCryptResults V2
########################
mkdir ResultsWithObjects$2
for file in $1/*.txt; do

    #file contained analyzed object 
    if cat $file | grep "Number of Objects" | grep -Eqo "[1-9]"; then
    	cp $file ResultsWithObjects$2/${file#${1}/}
    fi

    done
