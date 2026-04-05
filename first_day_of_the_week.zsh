#!/bin/zsh

# Usage: ./first_day_of_week.zsh [year] [week_number]

# Default to current ISO year and week
current_iso_year=$(date +%G)
current_iso_week=$(date +%V)

year=${1:-$current_iso_year}
week_number=${2:-$current_iso_week}

# Find Jan 4th (guaranteed to be in ISO week 1)
jan4="${year}-01-04"

# Find the Monday of ISO week 1
day_num=$(date -jf "%Y-%m-%d" "$jan4" +"%u")  # 1=Mon ... 7=Sun
first_monday=$(date -j -v-"$((day_num - 1))"d -f "%Y-%m-%d" "$jan4" +"%Y-%m-%d")

# Add (week_number - 1) weeks
first_day=$(date -j -v+"$(( (week_number - 1) * 7 ))"d -f "%Y-%m-%d" "$first_monday" +"%Y-%m-%d")

echo "The first day of ISO week $week_number in $year is $first_day"
