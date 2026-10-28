# Music Video Curator

A local-first macOS application for discovering, reviewing, cataloging and organizing music videos by artist.

**Status:** early development (v0.5 desktop foundation). No tested macOS installer has been published yet.

## Features in the prototype
- Artist watchlists and official-channel discovery using the YouTube Data API
- Review queue, video categorization, duplicate/version grouping
- Import and organize local or otherwise authorized media files
- Metadata sidecars and local SQLite catalog
- Plex/Jellyfin library refresh, backups and library health checks
- Desktop window prototype powered by Python, Flask and pywebview

The YouTube API is used for **discovery**, not for circumventing video-site download restrictions.

## Development setup
Requires Python 3.12 (3.10+ supported by project metadata).

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -e '.[desktop]'
music-video-curator
```

Set `YOUTUBE_API_KEY` in your environment or `.env` for discovery. Do not commit secrets, tokens, media files or local database files.

## macOS builds
The GitHub Actions workflow `.github/workflows/macos-build.yml` is intended to build separate Intel and Apple Silicon DMGs. It invokes `scripts/build-macos.sh`, which **must be present in the repository** before the workflow can succeed.

To run it: **Actions → macOS builds → Run workflow**. Build artifacts are unsigned and unnotarized until signing is configured.

## Planned release checklist
See [Issue #1](https://github.com/righteousboy07/music-video-curator/issues/1).

## Repository scope
This repository is only for **Music Video Curator**. Recipe capture and general video capture are separate applications.
