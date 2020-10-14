#!/bin/bash

# Get filename
IN=$1

# Check if output file exists
OUT="out.txt"
if [ -d $OUT ]
then
	rm "out.txt"
fi

# Add additional newline at the end (for reading purposes)
echo "" >> $IN

# Append newline to output file
s=""
while IFS= read -r  line 
do
	printf "%s " $line | tr -d '\n' >> $OUT
done < $IN

