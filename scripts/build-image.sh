#!/usr/bin/env bash
set -euo pipefail

VERSION="${VERSION:-SNAPSHOT}"
TARGET="${TARGET:-x86/64}"
PROFILE="${PROFILE:-generic}"
IMAGEBUILDER_URL="${IMAGEBUILDER_URL:-https://downloads.immortalwrt.org/snapshots/targets/x86/64/immortalwrt-imagebuilder-x86-64.Linux-x86_64.tar.zst}"
EXTRA_IMAGE_NAME="${EXTRA_IMAGE_NAME:-daed-deps}"
OUT_DIR="${OUT_DIR:-$PWD/out}"

EXTRA_PACKAGES="${EXTRA_PACKAGES:-luci kmod-sched-core kmod-sched-bpf kmod-veth kmod-xdp-sockets-diag vmlinux-btf v2ray-geoip v2ray-geosite}"

WORK_DIR="${WORK_DIR:-$PWD/work}"
IB_ARCHIVE="$WORK_DIR/imagebuilder.tar.zst"

mkdir -p "$WORK_DIR" "$OUT_DIR"

if [ ! -s "$IB_ARCHIVE" ]; then
  curl -L --retry 8 --retry-delay 5 --connect-timeout 30 \
    -o "$IB_ARCHIVE" "$IMAGEBUILDER_URL"
fi

rm -rf "$WORK_DIR/imagebuilder"
mkdir -p "$WORK_DIR/imagebuilder"
tar --use-compress-program=unzstd -xf "$IB_ARCHIVE" -C "$WORK_DIR/imagebuilder" --strip-components=1

cp -a files "$WORK_DIR/imagebuilder/files"

cd "$WORK_DIR/imagebuilder"

echo "Version: $VERSION"
echo "Target: $TARGET"
echo "Profile: $PROFILE"
echo "Extra packages: $EXTRA_PACKAGES"

make image \
  PROFILE="$PROFILE" \
  PACKAGES="$EXTRA_PACKAGES" \
  FILES=files \
  BIN_DIR="$OUT_DIR" \
  EXTRA_IMAGE_NAME="$EXTRA_IMAGE_NAME"

find "$OUT_DIR" -maxdepth 1 -type f -print
