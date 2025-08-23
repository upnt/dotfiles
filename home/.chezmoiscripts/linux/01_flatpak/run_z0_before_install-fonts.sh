#!/bin/bash
set -euo pipefail

LOG="/tmp/install_font.log"

run() {
  local msg="$1"
  shift
  echo ".${msg}"
  "$@" >>"$LOG" 2>&1
}

run "Downloading UDEVGothic v2.0.0" \
  wget https://github.com/yuru7/udev-gothic/releases/download/v2.0.0/UDEVGothic_NF_v2.0.0.zip >/dev/null
run "Extracting UDEVGothic v2.0.0" \
  unzip UDEVGothic_NF_v2.0.0.zip >/dev/null
mkdir -p "$HOME/.local/share/fonts/Unknown Vendor/TrueType/UDEV Gothic NF/"
mkdir -p "$HOME/.local/share/fonts/Unknown Vendor/TrueType/UDEV Gothic NFLG/"
mkdir -p "$HOME/.local/share/fonts/Unknown Vendor/TrueType/UDEV Gothic 35NF/"
mkdir -p "$HOME/.local/share/fonts/Unknown Vendor/TrueType/UDEV Gothic 35NFLG/"
mv UDEVGothic_NF_v2.0.0/UDEVGothicNF-* "$HOME/.local/share/fonts/Unknown Vendor/TrueType/UDEV Gothic 35NF/"
mv UDEVGothic_NF_v2.0.0/UDEVGothicNFLG-* "$HOME/.local/share/fonts/Unknown Vendor/TrueType/UDEV Gothic 35NFLG/"
mv UDEVGothic_NF_v2.0.0/UDEVGothic35NF-* "$HOME/.local/share/fonts/Unknown Vendor/TrueType/UDEV Gothic 35NF/"
mv UDEVGothic_NF_v2.0.0/UDEVGothic35NFLG-* "$HOME/.local/share/fonts/Unknown Vendor/TrueType/UDEV Gothic 35NFLG/"

rm UDEVGothic_NF_v2.0.0.zip
rm -r UDEVGothic_NF_v2.0.0
