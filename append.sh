#!/bin/bash

if [ "$#" -ne 1 ]; then
    	echo "Illegal number of parameters"
else 
	echo "$1";
	find ./"$1" -mindepth 1 -depth ! -name "* - $1*" -exec mv '{}' '{}'" - $1" \;
fi



