#!/bin/bash
#
# Sync rlog files from Comma device
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

# Sync only rlog.zst files with optimized settings for speed
rsync -rt --info=progress2 \
    --ignore-existing \
    --partial \
    --inplace \
    --include="*/" \
    --include="rlog.zst" \
    --exclude="*" \
    --prune-empty-dirs \
    -e "ssh -p ${SSH_PORT} -i ${SSH_KEY} -o StrictHostKeyChecking=no -o Compression=no -o ConnectTimeout=10 -o ControlMaster=auto -o ControlPath=~/.ssh/control-%h-%p-%r -o ControlPersist=10 -c aes128-gcm@openssh.com" \
    "${SSH_USER}@${DEVICE_IP}:${REMOTE_PATH}" \
    "${LOCAL_PATH}/"

echo ""
echo "Done! Logs in: ${LOCAL_PATH}"
