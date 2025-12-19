#!/bin/bash
set -e
export GITHUB_TOKEN="${GITHUB_TOKEN}"

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

cd /app
echo "[$(date)] Starting sending notification..."

# Go to app folder and run your script
echo "Running sendNotification.js..."
/usr/local/bin/npm run rates:notification

echo "[$(date)] Task completed."
