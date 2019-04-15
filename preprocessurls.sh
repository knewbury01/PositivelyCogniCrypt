###############################
# this will format the curl results 
# just so that they are a list of git urls from which
# we can iterate to clone
#
# takes arg of original curl result to process
#
# sample usage:
#    ./preprocessurls.sh curl1.txt
#
#
# WARNING PLATFORM SED
# mac sed command: 
#    sed -i '' 'expression' ect
# linux sed command:
#    sed -i 'expression' ect
#
###############################


cat $1 | grep "git_url" >> allrepos.txt 

#remove all quotations
sed -i 's/"//' allrepos.txt
sed -i 's/"//' allrepos.txt
sed -i 's/"//' allrepos.txt
sed -i 's/"//' allrepos.txt
#remove commas
sed -i 's/,//' allrepos.txt
#remove "git_url:"
sed -i 's/git_url://' allrepos.txt
#remove anything with android in the name
sed -i '/android/d' allrepos.txt
sed -i '/Android/d' allrepos.txt

echo -n "There are this many samples to fetch and clone: "
cat allrepos.txt | wc -l
