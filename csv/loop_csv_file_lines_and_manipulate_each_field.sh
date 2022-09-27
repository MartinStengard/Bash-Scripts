#!/bin/bash
# Loop file lines and split by each line to array.
# $1 = file to loop

line_counter=0

while read current_line; do
	((line_counter++))
	fields_changed=()

	while IFS=',' read -ra fields; do
		field_counter=0

		for field in "${fields[@]}"; do
			((field_counter++))

			case $field_counter in
				1 )
					fields_changed+=("$field changed")
					;;
				2 )
					fields_changed+=("$field changed")
					;;
			esac
		done
	done <<< "$current_line"

	echo "Line $line_counter:"
	echo "  values: ${fields_changed[@]}"
done < "$1"
