########################################
# curls for security related java lang repos
#
# loops over the number of pages we expect to exist for
# the result
# the endpoint is manually obtained from
# the equivalent github web gui search
#
# endpoint = ceiling[number results/100]
#
#########################################

 for pagenum in {1..2}; do 

     echo "curling for page $pagenum"
curl -H "Accept: application/vnd.github.mercy-preview+json" \
  "https://api.github.com/search/repositories?q=application+language:java&per_page=100&page=$pagenum&sort=stars" >> allreposjson.txt

     done
