#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sed -i '/alias rip=/d' ~/.bashrc
sed -i '/alias fix-m3u=/d' ~/.bashrc

cat << ALIASES >> ~/.bashrc
alias rip="PYTHONWARNINGS=\"ignore::UserWarning\" whipper cd rip -O \$HOME/Music/Staging --disc-template=\"%A - %d/%A - %d\" --track-template=\"%A - %d/%t - %n\""
alias fix-m3u="python3 $REPO_DIR/scripts/fix-m3u.py"
ALIASES

echo "Installed 'rip' and 'fix-m3u' aliases to ~/.bashrc."
echo "Run: source ~/.bashrc"
