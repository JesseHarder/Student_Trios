#!/bin/bash

# First argument is the csv file to use as initial input. If not given,
#	"/input/Input.csv" is used.
# Second argument is the path to write the final results to. If not given,
#	final results are printed to the screen.
# Third argument is the name that will be used for the .lp file the .csv file
# 	is translated into. If not specified, "preferences/Pref.lp" will be used
# 	and then deleted upon program completion.
# Fourth argument is the output of the ASP prgoram run. If not specified,
# 	"ASP_results/Results.txt" will be used and then deleted upon program completion.

CSV_FILE="input/Input.csv"
LP_FILE="preferences/Pref.lp"
ASP_OUTPUT="ASP_results/Results.txt"
OUTPUT_FILE=""

if [[ $# -ge 1 ]]; then
	CSV_FILE=$1
	if [[ $# -ge 2 ]]; then
		OUTPUT_FILE=$2
		if [[ $# -ge 3 ]]; then
			LP_FILE=$3
			if [[ $# -ge 4 ]]; then
				ASP_OUTPUT=$4
			fi
		fi
	fi
fi

echo \"$CSV_FILE\"
echo \"$OUTPUT_FILE\"
echo \"$LP_FILE\"
echo \"$ASP_OUTPUT\"
