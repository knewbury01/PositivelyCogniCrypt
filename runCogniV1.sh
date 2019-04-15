###########################
#runs CogniCrypt on the list
#of input items given in the argument
#
#assumes both CogniCrypt jar and JCA_Rules dir are in cwd
#
# sample usage:
#     ./runCogniV1.sh alljars.txt
#########################

mkdir CogniCryptResultsV1

while IFS='' read -r input || [[ -n "$input" ]]; do

    #chop the leading ./ off of each name in file, then replace all \/'s with -'s
    inputname="$(echo $input | sed -r 's/\.\///' |sed -r 's/\/+/-/g')"
    echo "RUNNING ON INPUT: $inputname"
    
    java -cp $(pwd)/CryptoAnalysis-1.0.0-jar-with-dependencies.jar crypto.HeadlessCryptoScanner --rulesDir=$(pwd)/JCA_rules --applicationCp=$(pwd)/$input &> CogniCryptResultsV1/${inputname}.txt
    

    done<$1
