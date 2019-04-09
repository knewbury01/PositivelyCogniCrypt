# Welcome to Falsely Positive CogniCrypt!
  * This is a project to investigate two things:
    * The presence of false positives in [CogniCrypt](https://github.com/CROSSINGTUD/CryptoAnalysis) reports
    * The feasibility of using Infoflow to aid in false positive detection


# Steps to Replicate:

  ## Data collection and processing:
    * This study looks at Java App projects on Github. Projects are ordered by number of stars, and this will fetch the first 200 results of the following Github rest API query:



    q=application+language:java&per_page=100&page=$pagenum&sort=stars    
  

    1. Collect a JSON formatted file of repo data:




    ./curlData.sh


    2. Extract just the Git urls:





    ./preprocessurls.sh


    3. Fetch and Build Projects:
    *Fetch the projects in the git url list and attempt to build these projects. Each repo that is cloned is checked to assess if it contains a (partially quantified) [JCA Core Class or Interface](https://docs.oracle.com/javase/9/security/java-cryptography-architecture-jca-reference-guide.htm#JSSEC-GUID-71693272-7F57-4155-99F9-A2139271FD6D). This is to assure that the data that is collected is actually relevant to crypto API usage. Only projects that use maven will be retained, and lastly the project must succeed in building. For projects meeting these criteria the project source will be retained, so that the jars can be extracted from the repo, and also that the source code can be used to manually verify false positives.





    ./fetchnbuild.sh




