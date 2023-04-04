#!/bin/bash
#

# Get the current timestamp
timestamp=$(date +"%Y-%m-%d %T")

# Append the timestamp to the file
echo "$timestamp" >> timestamp.txt

# Display a message to indicate that the script has run
echo "Script has run at $timestamp"

