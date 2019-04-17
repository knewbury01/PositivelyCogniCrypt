# Welcome to Falsely Positive CogniCrypt!
  * This is a project to investigate one important thing!:
    * The presence of false positives in [CogniCrypt](https://github.com/CROSSINGTUD/CryptoAnalysis) reports
  * We look at two versions of CogniCrypt, [Release 1.0.0](https://github.com/CROSSINGTUD/CryptoAnalysis/releases/download/v1.0.0/CryptoAnalysis-1.0.0-jar-with-dependencies.jar) and a build approximately from 2.0.0, specifically from sha:



       5f531d1d4377aefd35cec6658ae95308c6594244


  * this project uses some gnu specific bash commands (sed and grep variants)
  * some scripts may need a tweak, they will be annotated for such

# Steps to Replicate:
 ## Data collection and processing:
  * This study looks at Java App projects on Github. Projects are ordered by number of stars, and this will fetch the first 200 results of the following Github rest API query:



        q=application+language:java&per_page=100&page=$pagenum&sort=stars    
  

 ####  1. Collect a JSON formatted file of repo data:
 * A manual verification or grep from json is required to guarantee the number of stars or other importance metric is within a prefered range. For this study this yields projects with >430 stars. Ideally we include this criteria in the url query, but we did not! [Its not clear how to do that](https://developer.github.com/v3/search/)



        ./curlData.sh


 ####  2. Extract just the Git urls:
 * The first step will not persist to have the same results over time, for reproduction purposes it may be necessary to begin from this step, where json-file is the [allreposjson.txt](https://github.com/knewbury01/PositivelyCogniCrypt/blob/master/allreposjson.txt) file supplied in this project.




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

```
        ./runCogniCrypt.sh <file-of-items-to-analyze>

	./runCogniV1.sh <file-of-items-to-analyze>
```

 ## 6. Find Relevant Analysis Outputs:
 * Some analysis outputs will not contain objects to analyze. Some (although very few) will have failed. This step collects just those outputs that contain an analyzed object.

```
        ./partitionCogniResults.sh CogniCryptResults V2

	./partitionCogniResults.sh CogniCryptResultsV1 V1
```

 ## 7. Find Analysis Outputs Containing Constraint Error:
 * In this study we analyzed false positives in constraint errors specifically. This step isolates those results that contained at least one of this type of error. This also generates a template report for 

```
        ./findConstraintErrors.sh FPV1Log.txt V1

	./findConstraintErrors.sh FPV2Log.txt V2
```

  ## 8. Detect False Positives:
  * There will now be two files: FPV1Log.txt and FPV2Log.txt, generated. These should serve as the template to perform false positive detection. Inherently this labelling of each error as reported for each project, must be manual. However we make the results of our evaluation public.
  * The format by which the logs should be filled out (for subsequent auto generation of reports) will be, T for a true positive, and FP for a false positive. Each row of the file is labelled with the CogniCrypt output file name. Each error in each output should be reviewed and placed into the file in top down order of the report of the error, and each label should be placed with no spaces.
  * so for example, a report with 2 constraint errors, where the project name is X, the first error is True and the second error is False Positive, will have an entry in the log as such:

```

  X=TFP

```

 ## 9. Generate Reports:
 * This process assumes that the development environment has R installed, and also RScript
 * This process can produce reports on:
   * a general summary of the number of projects that were analyzed successfully, and found to be relevant and found to have at least one error
   * overall error type distributions
   * frequency counts of constraint errors reported across projects
   * a table of false positives as per the logs generated in the previous step
 * All figures and reports can be generated in one step by running:

```
  ./makeAllFigures.sh

```

 * Alternatively each step can be performed in isolation, simply by copying any such line from the makeAllFigures script.