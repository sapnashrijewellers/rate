#!/bin/bash
set -e

# --- Setup Git identity ---
git config --global user.name "Auto Data Bot"
git config --global user.email "autobot@sapnashrijewellers.com"

export GITHUB_TOKEN="$GITHUB_TOKEN"


# Export Docker env vars so cron can see them
printenv | grep -E 'GITHUB_TOKEN|NODE_ENV|TZ|PATH' >> /etc/environment

cd /app

echo "Running immediate data generation..."

/app/update-rates.sh || echo "Initial rate update failed, continuing..."

echo "Starting cron..."

cron -f