#######################
#not all projects will actually have
#an object of interest to analyze potentially
#so assure that the outputs we look at
#did have an interesting result
########################
mkdir ResultsWithObjects
for file in CogniCryptResults/*.txt; do

    #file contained analyzed object 
    if cat $file | grep "Number of Objects" | grep -Eqo "[1-9]"; then
    	cp $file ResultsWithObjects/${file#CogniCryptResults/}
    fi

    done
