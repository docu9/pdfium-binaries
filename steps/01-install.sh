#!/bin/bash -eux

PATH_FILE=${GITHUB_PATH:-.path}
OS=${PDFium_TARGET_OS:?}
CPU="${PDFium_TARGET_CPU:?}"

DepotTools_URL='https://chromium.googlesource.com/chromium/tools/depot_tools.git'
DepotTools_DIR="$PWD/depot_tools"
WindowsSDK_DIR="/c/Program Files (x86)/Windows Kits/10/bin/10.0.19041.0"

# Download depot_tools if not exists in this location
if [ ! -d "$DepotTools_DIR" ]; then
  git clone "$DepotTools_URL" "$DepotTools_DIR"
fi

echo "$DepotTools_DIR" >> "$PATH_FILE"

case "$OS-$CPU" in
  win-*)
    echo "$WindowsSDK_DIR/$CPU" >> "$PATH_FILE"
    ;;

  linux-arm)
    sudo apt-get update
    sudo apt-get install -y g++-arm-linux-gnueabihf
    ;;

  linux-arm64)
    sudo apt-get update
    sudo apt-get install -y g++-aarch64-linux-gnu
    ;;
esac