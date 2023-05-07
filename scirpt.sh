#!/bin/zsh

# Define the directory to monitor
dir_to_watch="$HOME"

# Define the script to execute on changes
script_to_run="/path/to/script.sh"

# Monitor the directory for changes
inotifywait -m -r -e create,delete,modify,move "$dir_to_watch" |
while read -r path action file; do
    # Check if the action was a Git commit
    if [[ $file == *.git/COMMIT_EDITMSG ]]; then
        # Get the commit message and timestamp
        commit_msg=$(cat "$path$file")
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")

        # Update the commits.md file with the commit message and timestamp
        echo "- $timestamp: $commit_msg" >> /Users/andresgonzales/Documents/projects/personal/commit-tracker/commits.md/commits.md

        # Run the script
        "$script_to_run"
    fi
done

# nohup /Users/andresgonzales/Documents/projects/personal/commit-tracker/scirpt.sh >/dev/null 2>&1 &