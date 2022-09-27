#!/usr/bin/env bash

# Looks for value in array.
# $1 = value_to_find
# $2 = array to search within
# @return 1 if value is contained in array, otherwise 0
findValueInArray() {
	local value_to_find="$1"
	shift
	for array_value in "$@"; do
		[[ $value_to_find == $array_value ]] && return 1;
	done
	return 0
}

# Array to search within.
testArray=("one" "two" "three" "four")

echo
echo "Values  in array -> ${testArray[@]}"
echo "---------------------------------------------------"
echo
echo "Task: find value '111' in array"
findValueInArray "111" "${testArray[@]}"
echo "Result -> $?"
echo "---------------------------------------------------"

echo
echo "Task: find value 'three' in array"
findValueInArray "three" "${testArray[@]}"
echo "Result -> $?"
echo "---------------------------------------------------"
echo

exit 0