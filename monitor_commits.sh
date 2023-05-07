#!/bin/sh

# Define the file to monitor
file_to_watch=""

# Define the commit count file
commit_count_file=""

# Define the Git repository location
repo_path=""

fswatch -0 "$file_to_watch" | while read -d "" event; do
  cd "$repo_path"

  # Make sure the remote origin is correct and update it if necessary
  remote_origin=""
  git remote set-url origin "$remote_origin"

  # Update the commit count file
  commit_count=$(wc -l < "$file_to_watch")
  echo "Total commits: $commit_count" > "$commit_count_file"

  # Perform Git operations
  git add .
  last_commit_msg=$(tail -n 1 "$file_to_watch" | awk -F': ' '{print $2}')
  git commit -m"$last_commit_msg"
  
  # Provide the password or use a credential manager
  # If using SSH, this line can be left as is
  git push origin main
done