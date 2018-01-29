#!/bin/bash

if [ "$#" -ne 1 ]; then
    	echo "Illegal number of parameters"
else
	find ./"$1" -mindepth 1 -depth -name "* - $1" | while read path; do
    		DIR=$(dirname "${path}")
		BASE=$(basename "${path}")
		suffix=" - $1"

		fixed_base="${BASE%$suffix}"
		target_path="$DIR"/"$fixed_base"

		mv "$path" "$target_path"
	done
fi
