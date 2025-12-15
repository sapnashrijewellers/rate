#!/bin/bash
set -e

export GITHUB_TOKEN="${GITHUB_TOKEN}"
# We include /usr/local/bin to be safe, even though we use the absolute path below.
export PATH="/app/node_modules/.bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin"

echo "[$(date)] Starting scheduled data generation..."

# Go to app folder and run your script
cd /app
echo "Running publish:rates script..."

# --- CRITICAL CHANGE ON THIS LINE ---
/usr/local/bin/npm run publish:rates

echo "[$(date)] Task completed."