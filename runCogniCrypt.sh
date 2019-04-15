###########################
#runs CogniCrypt on the list
#of input items given in the argument
#
#assumes both CogniCrypt jar and JCA_Rules dir are in cwd
#
# sample usage:
#     ./runCogniCrypt.sh alljars.txt
#########################

mkdir CogniCryptResults

while IFS='' read -r input || [[ -n "$input" ]]; do

    #chop the leading ./ off of each name in file, then replace all \/'s with -'s
    inputname="$(echo $input | sed -r 's/\.\///' |sed -r 's/\/+/-/g')"
    echo "RUNNING ON INPUT: $inputname"
    
    java -cp $(pwd)/CryptoAnalysis-2.1-SNAPSHOT-jar-with-dependencies.jar crypto.HeadlessCryptoScanner --rulesDir=$(pwd)/JCA_rules --applicationCp=$(pwd)/$input &> CogniCryptResults/${inputname}.txt
    

    done<$1
