#!/usr/bin/env python3
"""Rebuild .m3u playlist entries after MusicBrainz Picard renames FLAC files."""
import os
import subprocess
import sys

target_dir = next(iter(sys.argv[1:]), ".")

for root, _, files in os.walk(target_dir):
    m3us = [f for f in files if f.lower().endswith(".m3u")]
    flacs = sorted(f for f in files if f.lower().endswith(".flac"))
    if not m3us or not flacs:
        continue

    m3u_path = os.path.join(root, next(iter(m3us)))
    with open(m3u_path, "w", encoding="utf-8") as out:
        out.write("#EXTM3U\n")
        for f in flacs:
            flac_path = os.path.join(root, f)
            dur = round(float(subprocess.check_output((
                "ffprobe", "-v", "error", "-show_entries", "format=duration",
                "-of", "default=noprint_wrappers=1:nokey=1", flac_path
            )).strip()))
            out.write(f"#EXTINF:{dur},{f}\n{f}\n")
    print(f"Updated: {m3u_path} ({len(flacs)} tracks)")
