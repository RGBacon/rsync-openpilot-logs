# rsync-openpilot-logs

A simple bash script to sync and decompress rlog files from a Comma device running openpilot.

## Features

- Syncs only `rlog.zst` files via rsync over SSH
- Automatically decompresses logs using zstd
- Skips already decompressed files
- Shows progress during transfer

## Requirements

- `rsync`
- `zstd`
- SSH key configured for your Comma device

## Configuration

Edit the script to match your setup:

```bash
DEVICE_IP="192.168.1.124"    # Your Comma device IP
SSH_USER="comma"              # SSH username
SSH_PORT="22"                 # SSH port
SSH_KEY="$HOME/.ssh/id_ed25519"  # Path to your SSH key
REMOTE_PATH="/data/media/0/realdata/"  # Remote logs path
LOCAL_PATH="./openpilot_logs"  # Local destination
```

## Usage

```bash
./rsync_openpilot_logs.sh
```

Logs will be synced and decompressed to `./openpilot_logs/logs/`.

## License

MIT

