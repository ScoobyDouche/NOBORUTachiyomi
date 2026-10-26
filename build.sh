#!/usr/bin/env bash
# Build NoboruTachiyomi VPK for PS Vita
# Title ID: NBTACH001
set -euo pipefail

TITLE_ID="NBTACH001"
TITLE="NoboruTachiyomi"
OUT="NoboruTachiyomi.vpk"

echo "Generating param.sfo (TITLE_ID=${TITLE_ID})..."

python3 - <<'PY'
import struct, os

TITLE_ID = "NBTACH001"
TITLE    = "NoboruTachiyomi"

key_table = b""
data_table = b""
index_table = b""

def add_entry(key: str, value: bytes, data_fmt: int):
    global key_table, data_table, index_table
    key_off = len(key_table)
    data_off = len(data_table)
    key_table += key.encode("ascii") + b"\x00"
    data_table += value
    index_table += struct.pack("<HHIII",
        key_off, data_fmt, len(value), len(value), data_off)

add_entry("TITLE_ID", TITLE_ID.encode("ascii") + b"\x00", 0x0204)
add_entry("TITLE",    TITLE.encode("utf-8") + b"\x00",    0x0204)
add_entry("CATEGORY", b"MG\x00",                          0x0204)
add_entry("APP_VER",  b"01.00\x00",                       0x0204)

while len(key_table) % 4:
    key_table += b"\x00"

header_size = 20
index_size  = len(index_table)
key_off     = header_size + index_size
data_off    = key_off + len(key_table)

header = b"\x00PSF" + struct.pack("<IIII",
    0x00000101, key_off, data_off, 4)

sfo = header + index_table + key_table + data_table
os.makedirs("source/sce_sys", exist_ok=True)
with open("source/sce_sys/param.sfo", "wb") as f:
    f.write(sfo)
print(f"Wrote source/sce_sys/param.sfo  ({len(sfo)} bytes)")
PY

echo "Packaging ${OUT}..."
rm -f "${OUT}"
(
  cd source
  7z a -tzip -mx=9 -x'!.DS_Store' "../${OUT}" .
)

echo
echo "Done: ${OUT}"
echo "Title ID: ${TITLE_ID}"
echo "Data folder remains: ux0:data/noboru/  (compatible with old downloads)"
ls -lh "${OUT}"
