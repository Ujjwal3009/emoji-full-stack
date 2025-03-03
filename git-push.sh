#!/bin/bash

# Check if a commit message was provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide a commit message"
    echo "Usage: ./git-push.sh \"your commit message\""
    exit 1
fi

# Store the commit message
COMMIT_MESSAGE="$1"

# Add all changes
echo "Adding all changes..."
git add .

# Commit with the provided message
echo "Committing with message: $COMMIT_MESSAGE"
git commit -m "$COMMIT_MESSAGE"

# Push to origin main
echo "Pushing to origin main..."
git push origin main

# Check if push was successful
if [ $? -eq 0 ]; then
    echo "Successfully pushed to origin main!"
else
    echo "Error: Push failed"
    exit 1
fi 