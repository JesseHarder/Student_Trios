#!/bin/bash

# First argument is the csv file to use as initial input. If not given,
#	"/input/Input.csv" is used.
# Second argument is the name that will be used for the .lp file the .csv file
# 	is translated into. If not specified, "preferences/Pref.lp" will be used.
# Third argument is the output of the ASP prgoram run. If not specified,
# 	"ASP_results/Results.txt" will be used.
# Fourth argument is the output of the ASP prgoram run. If not specified,
# 	"ASP_results/Results.txt" will be used. If "print" is given, the result
# 	will be printed to the screen instead.

CSV_FILE="input/Input.csv"
LP_FILE="preferences/Pref.lp"
ASP_OUTPUT="ASP_results/Results.txt"
OUTPUT_FILE="output/FinalResults.txt"

# --- Filename Setup ---

if [[ $# -ge 1 ]]; then
	CSV_FILE=$1
	if [[ $# -ge 2 ]]; then
		LP_FILE=$2
		if [[ $# -ge 3 ]]; then
			ASP_OUTPUT=$3
			if [[ $# -ge 4 ]]; then
				OUTPUT_FILE=$4
			fi
		fi
	fi
fi

# --- Main Program ---

# Check for input file.
if ! [ -a $CSV_FILE ]; then
	echo "Input file couldn't be found."
	exit
fi
# Run ASP input generation.
python generate.py $CSV_FILE $LP_FILE

# Check for generate script output file.
if ! [ -a $LP_FILE ]; then
	echo "Input file couldn't be found."
	exit
fi

# Run ASP solver.
clingo group_assignment.lp $LP_FILE > $ASP_OUTPUT

# Check for solver output file.
if ! [ -a $ASP_OUTPUT ]; then
	echo "Input file couldn't be found."
	exit
fi

# Run output tidier.
if [ $OUTPUT_FILE == "print" ]; then
	clear
	python tidy.py $ASP_OUTPUT
else
	python tidy.py $ASP_OUTPUT > $OUTPUT_FILE
fi

echo "Program Execution Complete. Thanks for using Student Trio solver."
