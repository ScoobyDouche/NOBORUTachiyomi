@echo off
REM Build NoboruTachiyomi VPK for PS Vita
REM Title ID: NBTACH001

echo Generating param.sfo...
vita-mksfoex -s TITLE_ID=NBTACH001 "NoboruTachiyomi" param.sfo
if errorlevel 1 (
    echo Failed to generate param.sfo
    exit /b 1
)
move /Y param.sfo source\sce_sys\param.sfo

echo Packaging VPK...
if exist NoboruTachiyomi.vpk del NoboruTachiyomi.vpk
7z a -tzip -mx=9 "NoboruTachiyomi.vpk" -r .\source\* .\source\eboot.bin

echo.
echo Done: NoboruTachiyomi.vpk
echo Title ID: NBTACH001
echo Data folder remains: ux0:data/noboru/  (compatible with old downloads)
