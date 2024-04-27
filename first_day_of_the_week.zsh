#!/bin/zsh

# Usage: ./first_day_of_week.zsh <year> <week_number>

year=$1
week_number=$2

# macOS `date` format for ISO-8601 first day of the week calculation
start_of_year=$(date -jf "%Y-%m-%d" "${year}-01-01" +"%Y-%m-%d")
day_num=$(date -jf "%Y-%m-%d" "$start_of_year" +"%u")
day_diff=$(( (7 + 1 - day_num) % 7 )) # days to next Monday
first_monday=$(date -j -v+${day_diff}d -f "%Y-%m-%d" "$start_of_year" +"%Y-%m-%d")
first_day=$(date -j -v+"$(( (week_number - 1) * 7 ))"d -f "%Y-%m-%d" "$first_monday" +"%Y-%m-%d")

echo "The first day of week number $week_number in $year is $first_day"
