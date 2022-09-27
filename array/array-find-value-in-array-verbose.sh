#!/usr/bin/env bash

# Looks for value in array.
# $1 = value_to_find
# $2 = array to search within
# @return 1 if value is contained in array, otherwise 0
findValueInArray () {
	local array_value value_to_find="$1"
	echo "  Value to find in array (parameter 1) -> $value_to_find"

	# Shift parameter index one step forward,
	shift

	# Get all other parameters by using $@ (not $2).
	echo "  Values in array -> $@"
	echo "  Loop values in array"

	for array_value;
	do
		if [[ "$array_value" == "$value_to_find" ]]; then
			echo "    MATCH -> $value_to_find found in array"
			echo "    return 1"
			return 1
		fi
		echo "    No match -> $value_to_find != $array_value"
	done

	echo "  $value_to_find NOT found in array"
	echo "  return 0"

	return 0
}

# Array to search within.
testArray=("one" "two" "three" "four")

echo
echo "Task: find value '111' in array"
echo "---------------------------------------------------"
findValueInArray "111" "${testArray[@]}"
echo "Result -> $?"
echo "---------------------------------------------------"

echo
echo "Task: find value 'three' in array"
echo "---------------------------------------------------"
findValueInArray "three" "${testArray[@]}"
echo "Result -> $?"
echo "---------------------------------------------------"

exit 0