#!/bin/bash

# example usage: consolidate.sh consolidate.txt > consolidated.yaml

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_with_filenames>"
    exit 1
fi

echo "### consolidated yaml file ###"
echo "### generated: $(date) ###"
echo 

while IFS= read -r filename; do
    if [ -f $filename ]; then
        echo "### $filename ###"
        if [[ "$(head -n 1 $filename)" != "---" ]]; then
	    echo "---" 
        fi
        cat $filename
	echo
    else
	echo "$filename not found" >&2
    fi
done < "$1"

