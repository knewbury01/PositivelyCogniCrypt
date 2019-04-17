################################
#runs two versions of Cognicrypt build 
#on a bunch of small isolated case examples
#
#
#################################
rm 2.1.txt 1.0.txt

#LATEST VS COGNI - my own build
java -cp $(pwd)/../CryptoAnalysis-2.1-SNAPSHOT-jar-with-dependencies.jar crypto.HeadlessCryptoScanner  --rulesDir=$(pwd)/../JCA_Rules  --applicationCp=$(pwd)/target/classes/ >> 2.1.txt

#FIRST VS COGNI
java -cp $(pwd)/../CryptoAnalysis-1.0.0-jar-with-dependencies.jar crypto.HeadlessCryptoScanner  --rulesDir=$(pwd)/../JCA_Rules  --applicationCp=$(pwd)/target/classes/ >> 1.0.txt


