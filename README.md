# flac-rip-toolkit

A lightweight Linux workflow for bit-perfect Audio CD archiving using **whipper**, **MusicBrainz Picard**, and **Python**.

## Compatibility & Requirements

- **OS & Shell:** Linux with **Bash** (`~/.bashrc`). *Not compatible with Windows or macOS (`whipper` is Linux-only and requires `/dev/sr0`).*
- **Dependencies:** `whipper` (`cdrdao`, `cdparanoia`, `flac`), `ffmpeg` (`ffprobe`), `python3`, and `picard`.

Install dependencies on **Ubuntu / Debian / Linux Mint**:
```bash
sudo apt update && sudo apt install -y whipper ffmpeg python3 picard
```

Install dependencies on **Arch Linux**:
```bash
sudo pacman -S whipper ffmpeg python picard
```

## Pipeline

1. **Rip (`whipper`):** Extracts verified lossless `.flac` tracks alongside `.cue`, `.log`, and `.m3u` files into `~/Music/Staging` using `%t - %n` (`01 - Track Title.flac`) naming.
2. **Tag & Organize (`MusicBrainz Picard`):** Matches releases against MusicBrainz, embeds cover art and metadata, and moves album folders (along with companion `.cue`/`.log`/`.m3u` files) into your final music library.
3. **Sync Playlists (`fix-m3u.py`):** Rebuilds `.m3u` files using `ffprobe` track durations so playlist paths match Picard's renamed `.flac` files.

## Quick Setup

```bash
git clone https://github.com/evangelos-koufogiannis/flac-rip-toolkit.git
cd flac-rip-toolkit
./install.sh
source ~/.bashrc
```

### What `install.sh` Does
- Detects the local path of this repository.
- Removes any older `rip` or `fix-m3u` aliases in `~/.bashrc`.
- Appends two aliases (`rip` and `fix-m3u`) to `~/.bashrc` (it does **not** install system packages or overwrite your `~/.config/whipper/whipper.conf`).

Before ripping for the first time, calibrate your optical drive offset:

```bash
whipper drive analyze
whipper offset find
```

## Usage

- **Rip a single CD:** `rip` (or `rip -U` if the disc is not yet in MusicBrainz)
- **Batch rip multiple CDs:** `./scripts/batch-rip.sh`
- **Fix `.m3u` in current album folder (or recursively across library):**
  ```bash
  fix-m3u
  fix-m3u ~/Music
  ```
