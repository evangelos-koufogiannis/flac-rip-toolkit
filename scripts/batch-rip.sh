#!/usr/bin/env bash
set -e

STAGING_DIR="${1:-$HOME/Music/Staging}"
mkdir -p "$STAGING_DIR"

while true; do
    echo "Insert CD and press [Enter] to rip (or Ctrl+C to quit)..."
    read -r
    PYTHONWARNINGS="ignore::UserWarning" whipper cd rip \
        -O "$STAGING_DIR" \
        --disc-template="%A - %d/%A - %d" \
        --track-template="%A - %d/%t - %n"
    eject /dev/sr0 || true
done
