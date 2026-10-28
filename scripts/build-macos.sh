#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test -f pyproject.toml || { echo "Missing pyproject.toml: import application source first"; exit 1; }
test -f src/music_video_archivist/desktop.py || { echo "Missing desktop launcher"; exit 1; }
python3 -m pip install --upgrade pip
python3 -m pip install -e '.[desktop]'
python3 -m PyInstaller --noconfirm --clean --windowed --name "Music Video Curator" \
  --collect-all webview --collect-all flask \
  --add-data "src/music_video_archivist/templates:music_video_archivist/templates" \
  --add-data "src/music_video_archivist/static:music_video_archivist/static" \
  --hidden-import music_video_archivist.desktop \
  --osx-bundle-identifier "com.musicvideocurator.app" \
  --paths src src/music_video_archivist/desktop.py
mkdir -p release
hdiutil create -volname "Music Video Curator" -srcfolder "dist/Music Video Curator.app" \
  -ov -format UDZO "release/Music-Video-Curator-$(uname -m).dmg"
