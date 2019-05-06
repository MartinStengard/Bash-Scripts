#!/usr/bin/env bash

# File with strings to match and count within log file.
file_find="value-list.txt"

# Log file.
file_log="log-file.txt"

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

  # -e    translate \t as tab, not \t
  echo -e "$line_trimed\t$counts"
done < $file_find

exit 0
