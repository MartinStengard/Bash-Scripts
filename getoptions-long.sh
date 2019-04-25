#!/usr/bin/env bash

set -e
#set -u

# Arguments available.
# -h|--help
# -a|--longa
# -b|--longb

usage() {
	echo "Usage"
	echo "---------------------------------------------------"
	echo "-h | --help		Display"
	echo "-a | --longa		option a value"
	echo "-b | --longb		option b value"
	echo "---------------------------------------------------"
	echo ""
	exit 1
}

# Put arguments to an array.
args=()

# Replace long arguments into short version
for arg; do
	case "$arg" in
		--help)
			args+=( -h ) ;;
		--longa)
			args+=( -a ) ;;
		--longb)
			args+=( -b ) ;;
		*)
			args+=( "$arg" ) ;;
	esac
done

# Print arguments before and after transformation to see change.
#printf 'Arguments BEFORE: '; printf '%q ' "$@"; echo
set -- "${args[@]}"
#printf 'Arguments AFTER: '; printf '%q ' "$@"; echo

# Set default values for argument variables.
VARIABLE_NOT_SET="VARIABLE_NOT_SET"
VARIABLE_A=$VARIABLE_NOT_SET
VARIABLE_B=$VARIABLE_NOT_SET

while getopts ":ha:b:" OPTION; do
	case $OPTION in
		h)
			usage
			exit 0 ;;
		a)
			VARIABLE_A="$OPTARG" ;;
		b)
			VARIABLE_B="$OPTARG" ;;
		*)
			if [[ $OPTION = ":" && "$OPTARG" = "b" ]]; then
				VARIABLE_B=""
			else
				echo "Invalid option argument -$OPTARG"
			fi ;;
		?)
			echo "Invalid option argument: -$OPTARG"
			exit 1 ;;
	esac
done

# Check arguments.
checkRequiredArgument () {
	[[ "$1" == $notset || "$1" == "" ]] && echo "1" || echo "0"
}

# Check arguments.
if [ $(checkRequiredArgument "$VARIABLE_A") == "1" ]; then
	echo "Argument -a or --long_a need to be set and have a value."
	exit 1
fi

if [ $(checkRequiredArgument "$VARIABLE_B") = "1" ]; then
	echo "Argument -b or --long_b need to be set and have a value."
	exit 1
fi

# Result if all went okay.
echo "final VARIABLE_A -> $VARIABLE_A"
echo "final VARIABLE_B -> $VARIABLE_B"

exit 0