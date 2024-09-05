#!/bin/bash

wget https://github.com/yuru7/udev-gothic/releases/download/v2.0.0/UDEVGothic_NF_v2.0.0.zip
unzip UDEVGothic_NF_v2.0.0.zip
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
