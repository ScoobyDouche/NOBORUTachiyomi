# NoboruTachiyomi – changes from upstream Noboru

## Build / packaging
- **New Title ID**: `NBTACH001` (was `NOBOR0001`)
- **App name**: `NoboruTachiyomi`
- GitHub Actions workflow (`.github/workflows/build-vpk.yml`) builds a VPK on every push to `main`/`master` and on manual dispatch. Artifacts only — no auto-releases.
- Cross-platform `build.sh` added (Linux / macOS / WSL).
- `build.bat` updated for the new Title ID.

## Data compatibility
- Data path is **still** `ux0:data/noboru/` (and `uma0:data/noboru/`).
- Existing downloaded chapters, library, history and settings continue to work after installing the new VPK.

## Next focus
1. Offline reliability (ChapterSaver / Cache / `c.c` loading when completely offline)
2. Local import / CBZ improvements
3. Parser work only after offline is solid
