#!/bin/bash
# Read parameters from Jenkins
PROJECT_NAME="$1"
REPO_URL="$2"
TARGET_DIR="$3"
APACHE_SERVICE="apache2"  # Default, can be overridden

# Git clone/pull
if [ ! -d "$TARGET_DIR" ]; then
  git clone "$REPO_URL" "$TARGET_DIR"
else
  cd "$TARGET_DIR"
  git pull origin main  # Replace "main" with your branch
fi

# Check for changes and reload Apache
cd "$TARGET_DIR"
CHANGES=$(git diff HEAD@{1} HEAD --shortstat)
if [ ! -z "$CHANGES" ]; then
  echo "Changes detected! Reloading Apache..."
  sudo systemctl reload "$APACHE_SERVICE"
fi
