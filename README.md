# Bash Scripts

## Start up scipts in cron file (un start up)
* auto connect to VPN  
* auto reset UFW
* auto update/upgrade distro

## Arrays
### array-find-value-in-array.sh
* Loop array
* Find value in array

### array-find-value-in-array-verbose.sh
Same script as above but contains comments and vervose code.

## Getops
### getoptions-long.sh
Script shows an easy way of handling both long and short option arguments without using `eval`.

## Grep
### grep-logfile/grep-logfile-with-file-list-values.sh
Loop values from file and grep (exact word and count number of matches) against log file.

## Misc
### counter.sh
Counts up or down and displays counter in fixed position in terminal
Uses:
* tput
* cup
* seq $start $steps $end

### summarize-log-file.sh
Handles parsing of text file content and extracting predefined values.
