#!/bin/bash
# Run this script from your Mac terminal to deploy the site to EC2.
# Usage: bash deploy.sh

set -e

KEY="$HOME/$SSH_KEY"
HOST="ec2-user@ec2-3-215-103-177.compute-1.amazonaws.com"
REMOTE_DIR="/var/www/html"
SITE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Checking key file..."
if [ ! -f "$KEY" ]; then
  echo "ERROR: Key file not found at $KEY"
  echo "Place EC2 SSH_KEY safely in $HOME/.ssh in your home directory (~/) and try again."
  exit 1
fi

chmod 400 "$KEY"

echo "==> Deploying site to $HOST ..."
rsync -avz --progress \
  --exclude='.git' \
  --exclude='.gitignore' \
  --exclude='deploy.sh' \
  --exclude='.DS_Store' \
  -e "ssh -i $KEY -o StrictHostKeyChecking=accept-new" \
  "$SITE_DIR/" \
  "$HOST:$REMOTE_DIR"

echo ""
echo "✓ Deployed successfully!"
echo "  Visit: http://ec2-3-215-103-177.compute-1.amazonaws.com"
