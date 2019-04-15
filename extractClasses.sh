##################################
# extracts all classes dirs in target type dirs
# omits those that contain test, lib, dependency, 
#
##################################
rm allclasses.txt

find . -path '*/classes' | grep -v "\<test\>" | grep -v "\<lib\>" | grep -v "\<dep\>" >> allclasses.txt
total=$(cat allclasses.txt | wc -l)

echo "The number of collected analysis inputs is: $total"
