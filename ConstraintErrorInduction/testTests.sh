###########################
#Loops through the test files
#just to verify that they are indeed
#executable code
#
#
###########################
declare -a arr=("BufRead" "BaseEncode" "FileAsStr" "ScanLoop" "FileRead" "ScanNext")

for file in "${arr[@]}"
do
    echo "TESTING $file"
    echo "--------------------------------------------------------"
    java -cp .:$(pwd)/target/classes/ ConstraintErrorExample.ConstraintErrorExample.$file
    echo "--------------------------------------------------------"
done

#these ones require stdin
declare -a arrtwo=("ScanSysIn" "BufReadSysIn")
for file in "${arrtwo[@]}"
do
    echo "TESTING $file"
    echo "--------------------------------------------------------"
    java -cp .:$(pwd)/target/classes/ ConstraintErrorExample.ConstraintErrorExample.$file <<EOF 
SHA-256
EOF
    echo "--------------------------------------------------------"
done

echo "This one prompts, just type SHA-256"
java -cp .:$(pwd)/target/classes/ ConstraintErrorExample.ConstraintErrorExample.ConsoleIn
