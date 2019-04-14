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

while IFS='' read -r jar || [[ -n "$jar" ]]; do

    #chop the leading ./ off of each name in file, then replace all \/'s with -'s
    jarname="$(echo $jar | sed -r 's/\.\///' |sed -r 's/\/+/-/g')"
    echo "RUNNING ON $jarname"
    
    java -cp $(pwd)/CryptoAnalysis-2.1-SNAPSHOT-jar-with-dependencies.jar crypto.HeadlessCryptoScanner --rulesDir=$(pwd)/JCA_rules --applicationCp=$(pwd)/$jar &> CogniCryptResults/${jarname%.jar}.txt
    

    done<$1
