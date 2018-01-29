#!/bin/bash

function delete_directories {
        oneLevelUp="${1}";
	pathToOEBPS="${1}"OEBPS/;

	#delete directories if clean up is complete
	if ! does_file_exist "${pathToOEBPS}"*.html && ! does_file_exist "${pathToOEBPS}"*.css; then
		echo deleting directories META-INF OEBPS and mimetype..
		rm -r "${1}"META-INF/;
		rm -r "${pathToOEBPS}";
		rm "${1}"mimetype;
	else
		echo Cannot delete. directory "${pathToOEBPS}" contains one or more css/html files. 
	fi
	
	#delete directories containing xhtml if no html files are present
	if does_file_exist "${oneLevelUp}"*.xhtml && ! does_file_exist "${oneLevelUp}"*.html; then
		echo no html and xhtml detected deleting directory..;
		rm -r "${oneLevelUp}";
	fi
}

#will check if a given wildcard file path exists
function does_file_exist {
	for f in "${1}"; do
	    if [ -e "$f" ]; then 
		return 0
	    else 
		return 1
	    fi
	done
}

for d in */ ; do
    printf "\n";
    echo processing directory "${d}";
    delete_directories "${d}";
done


