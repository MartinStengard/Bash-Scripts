#!/bin/bash

# Format of line to process:
# Script will parse each line, extract predefined values
# and format. Produces a file or print in terminal summarized
# findings.
# ---------------------------------------------------------
# Date [tab] Text
# 2019-04-10 12:20:54	Line text to search for. Text one to extract 34798876, Text two to extract 420014 rest of log text.
# 2019-04-10 12:17:54	Line text to search for. Text one to extract 8700000, Text two to extract 850001 rest of log text.
# 2019-04-10 12:20:54	Line text to search for. Text one to extract 34798876, Text two to extract 420014 rest of log text.
# 2019-04-10 12:20:54	Line text to search for. Text one to extract 34798876, Text two to extract 420014 rest of log text.
# ---------------------------------------------------------

usage() {
	echo "Usage"
	echo "---------------------------------------------------"
	echo "-i	input file name (required)"
	echo "[-o]	output file name"
	echo "---------------------------------------------------"
	echo ""
	exit 1
}

# Helper function to see if array of tenants contain current tenant.
# $1 -> current tenant.
# @returns 1-exists, 0-do not exists.
findTenantInCollection() {
	for find_tenant in "${tenants[@]}"; do
		[[ "$1" == "$find_tenant" ]] && return 1;
	done
	return 0
}

# Print to console or file.
# $1 -> text to echo.
# $2 -> echo text to specified line number (for out file).
out() {
	if [[ $append_to_file == "1" ]]; then
		if [[ -z $2 ]]; then
			echo "$1" >> "$out_file"
		else
			sed -i "$2s/^/$1\n/" "$out_file"
		fi
	else
		echo "$1"
	fi
}

# Input file to loop.
current_file=""

# Output file to write result to.
out_file=""

# Flag, write to file.
append_to_file="0"

# String to find.
find_string="Line text to search for"

# Line count in file.
row_count=0

# List of unique tenants found.
tenants=()

# Parse input parameters
while getopts i:o: option
do
case "${option}" in
	i) current_file=${OPTARG};;
	o) out_file=${OPTARG};;
esac
done

# Check that input file name is exists.
if [ -z "$current_file" ]; then
	usage
fi

# Check that input file exists.
if [ ! -f "$current_file" ]; then
    echo "[-] File \"$current_file\" not found!"
	echo
	exit 1
fi

# Create output file if needed and set flag.
if [ ! -z "$out_file" ]; then
	echo "" > "$out_file"
	append_to_file="1"
	echo "[+] Output file $out_file created"
fi

out "[+] Filtering on lines containing string \"$find_string\" in input file."
out

# Loop each line in file that contains string to find ( < "$current_file")
while read p; do

  if [[ "$p" == *"$find_string"* ]]; then
		let row_count+=1

		# Get date before first tab.
		field_date=$(echo "$p" | cut -f1)

		# Get string after first tab.
		field_content=$(echo "$p" | cut -f2)

		# Get value between "text-one-start" and "text-one-end".
		revenue=$(echo "$field_content" | sed "s/.*text-one-start\(.*\)text-one-end.*/\1/" | tr -d "[:space:]" | sed ":a;s/\B[0-9]\{3\}\>/ &/;ta")
		revenue=$(printf "%11s" "$revenue")

		# Get id between "text-two-start" and "text-two-end".
		tenant=$(echo "$field_content" | sed "s/.*text-two-start:\(.*\)text-two-end.*/\1/" | tr -d "[:space:]")
		tenant=$(printf "%7s" "$tenant")

		# Find tenant in collection.
		findTenantInCollection "$tenant"
		tenant_found=$?

		# Add if tenant has not been added.
		if [[ tenant_found -eq 0 ]]; then
			# Add current tenant to collection.
			tenants+=("$tenant")
			out "$field_date >    Revenue: $revenue,  Tenant: $tenant"
		fi
	fi
done < "$current_file"

echo "[+] DONE"
echo

out "[+] ${#tenants[@]} unique tenants found in $row_count lines." 3

exit 0