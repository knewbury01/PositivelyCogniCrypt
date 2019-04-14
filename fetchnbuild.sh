######################
# this script iterates through
# the repo urls in allrepos.txt
# clones each, cds in and tries to build
# assuming the project uses mvn
# 
# cleans up after self
#
# WARNING sometimes this quits part way through... not sure why
# if this happens need to clip input file and manually resume
#
# puts all jars in projects
# keeps only jars that contain the name of the project...
# AND were found in some target directory somewhere
# otherwise we get lots of irrelevant jars...
#
# further on jars with any portion of "sources.jar"
# in their name were also removed
#
#
######################

mkdir projects
mkdir classes
var=0
pwdd=${pwd}

while IFS='' read -r repo || [[ -n "$repo" ]]; do

   
    #for https urls
    #reponame=`echo $repo | sed -e 's/https:\/\/github.com\/.*\/\(.*\).git/\1/'`
    
    #for ssh urls
    reponame=`echo $repo | sed -e 's/git:\/\/github.com\/.*\/\(.*\).git/\1/'`

    echo "CLONING $reponame"
    git clone $repo

    #sometimes the repo does not exist, so dont try rest of stuff
    if [  -d "$reponame" ]; then

	#actually this search would have been better...
	#"\<Provider\>|\<Security\>|\<SecureRandom\>|\<MessageDigest\>|\<Signature\>|\<Cipher\>|\<KeyFactory\>|\<KeyGenerator\>|\<KeyAgreement\>|\<KeyStore\>|> <CertificateFactory\>|\<KeyPair\>|\<KeySpec\>|\<AlgorithmParameter\>"
	#test if this directory has the one of the interesting keywords in it 
	if grep -RqE "Provider|Security|SecureRandom|MessageDigest|Signature|Cipher|KeyFactory|KeyGenerator|KeyAgreement|KeyStore|CertificateFactory|KeyPair|KeySpec|AlgorithmParameter" $reponame;

	   then

	       var=$((var+1))
	       cd $reponame
	
	
	#get the latest sha of this, for reproducibility
	echo -n "$repo " >> ../commitlog.txt
 	git rev-parse HEAD >> ../commitlog.txt
    
	#attempt build, and only proceed if it succeeds, otherwise just rm this dir
	if mvn package -Dmaven.test.skip=true | grep "SUCCESS"; then

	    #also keep a separate list of the projects that built
	    echo -n "$repo " >> ../successcommitlog.txt
            git rev-parse HEAD >> ../successcommitlog.txt

	    #finds all jars in ONLY target dir
	found=`find . -path 'target/*' -regex ".*jar"`
	for each in $found:
	do
		echo "FOUND THIS JAR $each"
		if [ -f "${each}" ]; then
			mv $each ../projects/
		fi
	done

	#try to also keep the classes dir...
	mv target/classes ../classes/${reponame}classes


	else

	    #mvn package attempt did not succeed
	    cd $pwd
	    rm -rf $reponame

	fi

	#use full path bc maybe we already cd'd here prev
	cd $pwd
	
	else
	    #do not keep dirs that do not contain any in the keyword set, too much clutter
	    cd $pwd
	    rm -rf $reponame 
	
	
	fi
	
    fi
    
    done<allrepos.txt

#filter out the javadocs and sources jars for the resulting project folder
rm projects/*javadoc.jar
rm projects/*sources.jar

./summaryFetch.sh
