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
var=0
pwdd=${pwd}

echo "THIS IS PWD $pwdd"


while IFS='' read -r repo || [[ -n "$repo" ]]; do

   
    #for https urls
    #reponame=`echo $repo | sed -e 's/https:\/\/github.com\/.*\/\(.*\).git/\1/'`
    
    #for ssh urls
    reponame=`echo $repo | sed -e 's/git:\/\/github.com\/.*\/\(.*\).git/\1/'`

    echo "CLONING $reponame"
    git clone $repo

    #sometimes the repo does not exist, so dont try rest of stuff
    if [  -d "$reponame" ]; then

	#test if this directory has the one of the interesting keywords in it 
	#uses an exact match pattern
	if grep -RqE "\<Provider\>|\<Security\>|\<SecureRandom\>|\<MessageDigest\>|\<Signature\>|\<Cipher\>|\<KeyFactory\>|\<KeyGenerator\>|\<KeyAgreement\>|\<KeyStore\>|> <CertificateFactory\>|\<KeyPair\>|\<KeySpec\>|\<AlgorithmParameter\>"  $reponame;

	   then

	       var=$((var+1))
	       cd $reponame
	
	
	#get the latest sha of this, for reproducibility
	echo -n "$repo " >> $pwdd/commitlog.txt
 	git rev-parse HEAD >> $pwdd/commitlog.txt
    
	#attempt build, and only proceed if it succeeds, otherwise just rm this dir
	if mvn compile | grep "SUCCESS"; then

	    #also keep a separate list of the projects that built
	    echo -n "$repo " >> $pwdd/successcommitlog.txt
            git rev-parse HEAD >> $pwdd/successcommitlog.txt
	    #keep a list as well of plain names of projects, for a quick cleanup if need be
	    echo "$reponame" >> $pwdd/projectsample.txt
	    
	else

	    #mvn compile attempt did not succeed
	    cd $pwdd
	    rm -rf $reponame

	fi

	#use full path bc maybe we already cd'd here prev
	cd $pwdd
	
	else
	    #do not keep dirs that do not contain any in the keyword set, too much clutter
	    cd $pwdd
	    rm -rf $reponame 
	
	
	fi
	
    fi
    
    done<allrepos.txt

