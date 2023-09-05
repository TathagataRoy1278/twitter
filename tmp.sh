#!/bin/bash

# Define the number of commits to make
num_commits=10

# Get the current date and time in seconds since the epoch
current_time=$(date +%s)

# Calculate the date ten days ago in seconds
ten_days_ago=$((current_time - 864000)) # 864000 seconds = 10 days

# Initialize an array to keep track of modified files
declare -a modified_files

# List all files in the Git repository
all_files=$(ls ~/tmp/nextjs-twitter)

# Iterate to make commits
for ((i = 0; i < num_commits; i++)); do
  # Randomly select a file that hasn't been modified yet
  while true; do
    random_file=$(echo "$all_files" | shuf -n 1)
    if ! [[ "${modified_files[*]}" =~ $random_file ]]; then
      break
    fi
  done

  # Add the selected file to the list of modified files
  modified_files+=("$random_file")

  # Generate a random date within the last ten days
  random_date=$((ten_days_ago + (RANDOM % 864000)))

  # Format the random date for Git commit
  formatted_date=$(date -d "@$random_date" "+%Y-%m-%d %H:%M:%S")

  # Create a random commit message
  read -p "Enter: " commit_message

  # Modify the selected file to trigger a change
  echo "Random content" >> "$random_file"

  # Stage the changes
  git add "$random_file"

  # Commit the changes with the random date and message
  GIT_AUTHOR_DATE="$formatted_date" GIT_COMMITTER_DATE="$formatted_date" git commit -m "$commit_message"
done
Random content
