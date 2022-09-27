#!/usr/bin/env bash

# File with strings to match and count within log file.
file_find="value-list.txt"

# Log file.
file_log="log-file.txt"

printf '\e[38;5;69m\e[48;5;253mValue\tMatches\n'

# Loop our list of strings to find and count values.
while read current_line; do
  # For each line, grep and count.

  # Remove new line at end of line, otherwise string will not be found.
  # -d    delete
  # '\r'  new line
  line_trimed=$(echo $current_line | tr -d '\r')

  # -w    match exact word
  # -c    counter matches
  counts=$(grep -wc $line_trimed $file_log)

  printf "$line_trimed\t$counts\n"
done < $file_find

printf '\e[38;5;196m%03d Foreground color: red\n'
printf '\e[48;5;201m%03d Background color: pink\n'
printf '\e[0m'
printf '\e[K'
echo
#for((i=16; i<256; i++)); do
#    printf "\e[48;5;${i}m%03d" $i;
#    printf '\e[0m';
#    [ ! $((($i - 15) % 6)) -eq 0 ] && printf ' ' || printf '\n'
#done

exit 0
