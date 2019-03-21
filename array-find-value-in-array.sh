#!/usr/bin/env bash

findValueInArray() {
	local value_to_find="$1"
	echo "  Value to find in array -> $value_to_find"
	shift

	echo "  Values in array -> $@"
	
	echo "  Loop values in array"
	for array_value in "$@"
	do
		echo "    Value in array -> $array_value"
		if [[ $value_to_find == $array_value ]]; then
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