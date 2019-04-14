##################################
# extracts all jars in target type dirs
# omits those that contain test, lib, dependency, 
#
# checks to make sure the number of uniquely named jars
# is the same as the number obtained in the alljars file
# up to the user to correct if not the case
##################################
rm alljars.txt

find . -path '*/target/*' -regex ".*.jar" | grep -v "lib" | grep -v "dependency" | grep -v "test" >> alljars.txt
unique=$(find . -path '*/target/*' -regex ".*.jar" | grep -v "lib" | grep -v "dependency" | grep -v "test" | sed 's/.*target//' | sort -u | wc -l)
total=$(cat alljars.txt | wc -l)

echo "The number of uniquely named files is: $unique"
echo "The number of collected files is: $total"
