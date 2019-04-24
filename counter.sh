#!/usr/bin/env bash

# Counts up/dow according to paramters.
# $1 = start number
# $2 = end number
# $3 = step number
# @return echo countdown sequense
counter() {
	start=$1
	end=$2
	steps=$3

	# Clear screen.
	clear

	# Message to display before counter.
	msg="... "

	# Place cursor one row down.
	tput cup 1 0

	# Print message.
	echo -n "$msg"

	# Get length of display text.
	length="${#msg}"

	# Loop over counter parameters.
	for i in $( seq $start $steps $end )
	do
		tput cup 1 $length
		echo -n  "$i "
		sleep 1
	done
}

# Example -> count from 10 to 1, step -1.
counter 10 1 -1

# Example -> count from 1 to 5, step 1.
counter 1 5 1
