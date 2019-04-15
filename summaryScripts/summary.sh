#$1 is the dir to summarize

    echo -n "Number of results containing no violation: "    
    cat $1/*.txt | grep "No violation" | wc -l

    echo -n "Number of results containing a finished output: "
    cat $1/*.txt | grep "Analysis finished" | wc -l
    
    echo -n "Number of results where no objects were analyzed: "
    cat $1/*.txt | grep "Number of Objects Analyzed: 0" | wc -l

    echo -n "Number of results where at least one object was analyzed: "
    cat $1/*.txt |  grep "Number of Objects" | grep -E "[1-9]" | wc -l


    echo -n "Number of results where there was at least one error: "
    cat $1/*.txt |  grep "found the following violations"  | wc -l

    
