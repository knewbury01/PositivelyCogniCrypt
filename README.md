# Welcome to Falsely Positive CogniCrypt!
  * This is a project to investigate two things:
    * The presence of false positives in [CogniCrypt](https://github.com/CROSSINGTUD/CryptoAnalysis) reports
    * The feasibility of using Infoflow to aid in false positive detection


# Steps to Replicate:
 ## Data collection and processing:
  * This study looks at Java App projects on Github. Projects are ordered by number of stars, and this will fetch the first 200 results of the following Github rest API query:



          q=application+language:java&per_page=100&page=$pagenum&sort=stars    
  

 ####  1. Collect a JSON formatted file of repo data:




    	  ./curlData.sh


 ####  2. Extract just the Git urls:





        ./preprocessurls.sh <json-file>


 #### 3. Fetch and Build Projects:
 * Fetch the projects in the git url list and attempt to build these projects. Each repo then goes through a few criteria that determine if it will be retained in the final sample. Each project must be cloned in order to check these criteria:
   * checked to assess if it contains a (partially quantified) [JCA Core Class or Interface](https://docs.oracle.com/javase/9/security/java-cryptography-architecture-jca-reference-guide.htm#JSSEC-GUID-71693272-7F57-4155-99F9-A2139271FD6D). This is to assure that the data that is collected is actually relevant to crypto API usage.
   * Only projects that use maven will be retained. This criteria is implicitly enforced by assuming the project uses Maven, and we attempt to build using the following mvn command.


     	 mvn compile

	 
   * Lastly the project must succeed in building. For projects meeting these criteria the project source will be retained, so that we can run the analysis right on bytecodes generated in each project directory, and also that the source code can be used to manually verify false positives.




   
	  ./fetchnbuild.sh

 ## 4. Filtering project items:
 * from this process we must extract a list of items we actually wish to analyze. 



   	  ./extractClasses.sh

 ## 5. Running Analysis:
 * Once we have a set of sample projects, run CogniCrypt.
 * We supply the version of CogniCrypt that we use, however we did not distribute the rules, as they are a bit larger. You will have to obtain them from [here](https://github.com/CROSSINGTUD/CryptoAnalysis/releases/download/2.0/JCA_rules.zip)



       	 ./runCogniCrypt.sh <file-of-items-to-analyze>


 ## 6. Find Relevant Analysis Outputs:
 * Some analysis outputs will not contain objects to analyze. Some (although very few) will have failed. This step collects just those outputs that contain an analyzed object.



      	 ./partition CogniResults.sh


 ## 7. Find Analysis Outputs Containing Constraint Error:
 * In this study we analyzed false positives in constraint errors specifically. This step isolates those results that contained at least one of this type of error.




        ./findConstraintErrors.sh