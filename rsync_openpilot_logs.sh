#!/bin/bash
#
# Sync rlog files from Comma device and decompress them
#

set -euo pipefail

#=== Configuration ===
DEVICE_IP="192.168.1.124"
SSH_USER="comma"
SSH_PORT="22"
SSH_KEY="$HOME/.ssh/id_ed25519"
REMOTE_PATH="/data/media/0/realdata/"
LOCAL_PATH="./openpilot_logs"

#=== Main ===

echo "Syncing rlogs from ${DEVICE_IP}..."

# Sync only rlog.zst files
rsync -rtW --info=progress2 \
    --update \
    --include="*/" \
    --include="rlog.zst" \
    --exclude="*" \
    --prune-empty-dirs \
    -e "ssh -p ${SSH_PORT} -i ${SSH_KEY} -o StrictHostKeyChecking=no -o Compression=no -c aes128-gcm@openssh.com" \
    "${SSH_USER}@${DEVICE_IP}:${REMOTE_PATH}" \
    "${LOCAL_PATH}/"

# Create hard symlink so logs/ points to the synced data
ln -sfn . "${LOCAL_PATH}/logs" 2>/dev/null || true

echo ""
echo "Done! Logs in: ${LOCAL_PATH}"
