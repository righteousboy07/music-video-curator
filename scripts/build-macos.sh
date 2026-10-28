#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This installer must be built on macOS." >&2; exit 1
fi
for path in pyproject.toml src/music_video_archivist/desktop.py; do
  if [[ ! -f "$path" ]]; then echo "Missing $path. Import application source first." >&2; exit 1; fi
done

ARCH="$(uname -m)"
case "$ARCH" in arm64|x86_64) ;; *) echo "Unsupported Mac architecture: $ARCH" >&2; exit 1 ;; esac
python3 -m pip install -e '.[desktop]'
python3 -m PyInstaller --noconfirm --clean --windowed \
  --name "Music Video Curator" \
  --osx-bundle-identifier "com.musicvideocurator.app" \
  --collect-all webview \
  --paths src \
  src/music_video_archivist/desktop.py
APP="dist/Music Video Curator.app"
test -d "$APP" || { echo "App bundle not produced" >&2; exit 1; }
mkdir -p release
hdiutil create -volname "Music Video Curator" -srcfolder "$APP" -ov -format UDZO \
  "release/Music-Video-Curator-$ARCH.dmg"
